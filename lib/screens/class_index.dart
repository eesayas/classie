import '../exports.dart';

class ClassIndex extends StatefulWidget {
  static const routeName = '/class-index';

  @override
  _ClassIndexState createState() => _ClassIndexState();
}

class _ClassIndexState extends State<ClassIndex> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Classes>(context).fetchClasses().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final classesData = Provider.of<Classes>(context);
    final classes = classesData.classes;

    return new Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: logoWhite, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text('my classes',
                style: TextStyle(
                    color: logoWhite,
                    fontWeight: FontWeight.w900,
                    fontSize: 35)),
          ),
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
                    colors: [purpleColor, purpleColorEnd])),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),

              //loop through classes
              child: ListView.builder(
                  itemCount: classes.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: classes[i],
                      //display values per card
                      child: ClassCard())),
            )));
  }
}
