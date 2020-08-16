import '../exports.dart';

// This screen will appear if there are no live classes
class NoClass extends StatefulWidget {
  @override
  _NoClassState createState() => _NoClassState();
}

class _NoClassState extends State<NoClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            'classie',
            style: TextStyle(
                color: HexColor('eeedfa'),
                fontWeight: FontWeight.w900,
                fontSize: 35.0),
          ),
        ),
        backgroundColor: HexColor('9247f3'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [HexColor('#9247F3'), HexColor('#D1B1FA')])),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'There are no live classes yet',
                style: TextStyle(fontSize: 20.0),
              ),
              RaisedButton(
                onPressed: () => {Navigator.pushNamed(context, '/class-index')},
                child: Text(
                  'VIEW ALL CLASSES',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
