import '../exports.dart';

class SendAlarmWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                TwilioSender().sendMessage('+17802786076', 'hello');
              },
              child: Text('hello'))
        ],
      ),
    ));
  }
}
