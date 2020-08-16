import '../exports.dart';

class ClassShow extends StatefulWidget {
  static const routeName = '/class-show';

  final String classId;

  ClassShow({this.classId});

  @override
  _ClassShowState createState() => _ClassShowState();
}

class _ClassShowState extends State<ClassShow> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    print(widget.classId);
  }

  @override
  void didChangeDependecies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    super.didChangeDependencies();
  }

  //This method will trigger barcode scanner
  Future<String> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#00D355', "Cancel", true, ScanMode.BARCODE);

      return barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = "Failed to get platform version.";
    }

    if (!mounted) return null;
  }

  @override
  Widget build(BuildContext context) {
    // get the live class
    final classData = Provider.of<Class>(context);

    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: logoWhite, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
              child: Text(classData.className,
                  style: TextStyle(
                      color: HexColor('#EEEDFA'),
                      fontWeight: FontWeight.w900,
                      fontSize: 35))),
          backgroundColor: HexColor('#9247F3'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.menu, size: 30, color: logoWhite),
                onPressed: () {
                  //show menu
                })
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [HexColor('#9247F3'), HexColor('#D1B1FA')])),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: Column(children: <Widget>[
                ClassCard(),
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: classData.checkedInStudents.length,
                        itemBuilder: (BuildContext context, int index) =>
                            StudentCard(classData.checkedInStudents[index]))),
              ]),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //scan barcode and look for it in the schedule
            String barcodeId = await scanBarcodeNormal();
            Map<String, dynamic> studentData =
                studentInSchedule(classData.adherence, barcodeId);

            //send check in student request to provider
            classData.checkInStudent(classData.id, studentData);
          },
          child: Icon(Icons.person_add, color: HexColor('#6231C4')),
          backgroundColor: HexColor('#eeedfa'),
        ));
  }
}

// This will return student data from schedule
Map<String, dynamic> studentInSchedule(Schedule schedule, String barcodeId) {
  //get the slots of schedule as an array
  var slots = schedule.spots.map((spot) => spot.slots).toList();
  Map<String, dynamic> foundStudent = {};

  //loop through all slot looking for student that has barcodeId
  slots.forEach((slot) => {
        slot.forEach((spot) => {
              if (spot.student.barcodeId == barcodeId)
                {
                  foundStudent['span'] = spot.span,
                  foundStudent['student'] = spot.student.id,
                }
            })
      });

  return foundStudent;
}
