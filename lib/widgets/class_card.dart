import 'package:classie/exports.dart';

import '../providers/class.dart';

/*
@desc This will be shown in the Class Index and Class Show header
*/
typedef void StringCallback(String val);

class ClassCard extends StatelessWidget {
  final StringCallback callback;
  ClassCard({this.callback});

  @override
  Widget build(BuildContext context) {
    //define data
    final classData = Provider.of<Class>(context);

    //see if in class index route to show/hide class name on each class
    final inIndex =
        ModalRoute.of(context).settings.name == '/class-index' ? true : false;
    return ChangeNotifierProvider.value(
      value: classData,
      child: InkWell(
          child: Stack(
            children: <Widget>[
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                          child: inIndex
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                  child: Text(
                                    classData.className,
                                    style: TextStyle(
                                        color: textPurple, fontSize: 22),
                                  ),
                                )
                              : Container()),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                // PRESENT
                                Column(
                                  children: <Widget>[
                                    InkWell(
                                      child: ClipOval(
                                        child: Container(
                                          color: HexColor('#6231c4'),
                                          height: 70.0, // height of the button
                                          width: 70.0, // width of the button
                                          child: Center(
                                              child: Text(
                                                  '${classData.checkedInStudents.length}',
                                                  style: TextStyle(
                                                      color: logoWhite,
                                                      fontSize: 22))),
                                        ),
                                      ),
                                      onTap: !inIndex
                                          ? () {
                                              callback("ON_TIME");
                                            }
                                          : null,
                                    ),
                                    Center(
                                        child: Text('on time',
                                            style: TextStyle(
                                                color: HexColor('#5027b3'),
                                                fontSize: 18)))
                                  ],
                                ),
                                //OVERTIME
                                Column(
                                  children: <Widget>[
                                    InkWell(
                                      child: ClipOval(
                                        child: Container(
                                          color: HexColor('#c94f4f'),
                                          height: 70.0, // height of the button
                                          width: 70.0, // width of the button
                                          child: Center(
                                              child: Text(
                                                  '${classData.overtimeStudents.length}',
                                                  style: TextStyle(
                                                      color: logoWhite,
                                                      fontSize: 22))),
                                        ),
                                      ),
                                      onTap: !inIndex
                                          ? () {
                                              callback("OVERTIME");
                                            }
                                          : null,
                                    ),
                                    Center(
                                        child: Text('overtime',
                                            style: TextStyle(
                                                color: HexColor('#F40000'),
                                                fontSize: 18)))
                                  ],
                                ),
                                // SIGNED OUT
                                Column(
                                  children: <Widget>[
                                    InkWell(
                                      child: ClipOval(
                                        child: Container(
                                          color: HexColor('#7e7d7d'),
                                          height: 70.0, // height of the button
                                          width: 70.0, // width of the button
                                          child: Center(
                                              child: Text(
                                                  '${classData.checkedOutStudents.length}',
                                                  style: TextStyle(
                                                      color: logoWhite,
                                                      fontSize: 22))),
                                        ),
                                      ),
                                      onTap: !inIndex
                                          ? () {
                                              callback("SIGNED_OUT");
                                            }
                                          : null,
                                    ),
                                    Center(
                                        child: Text('signed out',
                                            style: TextStyle(
                                                color: HexColor('#6c6c6c'),
                                                fontSize: 18)))
                                  ],
                                ),
                              ]))
                    ],
                  ))
            ],
          ),
          onTap: () => {
                //only fire id in /class-index route
                if (inIndex)
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                            value: classData,
                            child: ClassShow(
                              classId: classData.id,
                            ))))
                  }
              }),
    );
  }
}
