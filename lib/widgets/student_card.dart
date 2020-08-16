import '../exports.dart';

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
              print('show check out dialog');
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      CheckOutDialog(studentData));
            },
          ),
        ));
  }
}
