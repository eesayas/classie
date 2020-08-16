import '../exports.dart';

class AddClass extends StatefulWidget {
  @override
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Icon(Icons.add, color: textPurple, size: 50),
                )),
              ]),
        ),
        Center(
            child: Text('Add more classes by clicking ‘+’ sign',
                style: TextStyle(color: mildWhite)))
      ],
    );
  }
}
