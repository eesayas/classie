import '../exports.dart';
import 'package:intl/intl.dart';

class CheckOutDialog extends StatelessWidget {
  final Map<String, dynamic> studentData;

  CheckOutDialog(this.studentData);

  @override
  Widget build(BuildContext context) {
    //define data
    final classData = Provider.of<Class>(context);

    //button click
    void onButtonClick() {
      if (studentData['student']['checkedIn']) {
        classData.checkOutStudent(classData.id, studentData);
        Navigator.pop(context, true);
      } else {
        print('send 2nd alarm');
      }
    }

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, //wrap content height-wise
            children: <Widget>[
              Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    '${studentData['student']['firstName']} ${studentData['student']['lastName']}',
                    style: TextStyle(
                        color: HexColor('5027b3'),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    studentData['student']['checkedIn']
                        ? 'Checked In on: ${DateFormat('jm').format(DateTime.parse(studentData['startTime']).toLocal())}'
                        : 'Checked Out on: 4:30pm',
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              ]),
              ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  color: HexColor('C94F4F'),
                  onPressed: () {
                    onButtonClick();
                  },
                  child: Text(
                    studentData['student']['checkedIn']
                        ? 'SIGN OUT'
                        : 'SEND ALARM',
                    style: TextStyle(color: HexColor('EEEDFA'), fontSize: 20.0),
                  ),
                ),
              ),
              Text(
                studentData['student']['checkedIn']
                    ? ''
                    : 'Student still waiting?',
                style: TextStyle(
                    fontSize: studentData['student']['checkedIn'] ? 0 : 15.0),
              ),
            ],
          ),
        ));
  }
}
