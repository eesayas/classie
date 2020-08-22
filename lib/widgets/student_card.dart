import '../exports.dart';
import 'package:intl/intl.dart';

class StudentCard extends StatelessWidget {
  final Map<String, dynamic> studentData;

  StudentCard(this.studentData);

  @override
  Widget build(BuildContext context) {
    //define data
    final classData = Provider.of<Class>(context);

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Wrap(
                  runAlignment: WrapAlignment.spaceEvenly,
                  spacing: 30,
                  runSpacing: 10,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          '${studentData['student']['firstName']} ${studentData['student']['lastName']}'),
                      subtitle: Text(studentData['status']),
                    ),
                  ],
                )
              ],
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                                    color: HexColor('c94f4f'),
                                    onPressed: () {
                                      if (studentData['student']['checkedIn']) {
                                        classData.checkOutStudent(
                                            classData.id, studentData);
                                        Navigator.pop(context, true);
                                      }
                                    },
                                    child: Text(
                                      studentData['student']['checkedIn']
                                          ? 'SIGN OUT'
                                          : 'SEND ALARM',
                                      style: TextStyle(
                                          color: HexColor('EEEDFA'),
                                          fontSize: 20.0),
                                    ),
                                  )),
                              Text(
                                studentData['student']['checkedIn']
                                    ? ''
                                    : 'Student still waiting?',
                                style: TextStyle(
                                    fontSize: studentData['student']
                                            ['checkedIn']
                                        ? 0
                                        : 15.0),
                              ),
                            ]),
                      )));
            },
          ),
        ));
  }
}
