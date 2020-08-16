import '../controllers/twilio_sender.dart';
import '../exports.dart';

class StudentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              TwilioSender()
                  .sendMessage('+17802786076', 'John is ready to picked up!');
            },
            child: Text('SEND ALARM'),
          )
        ],
      ),
    );
  }
}
