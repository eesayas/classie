import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import '../exports.dart';

class TwilioSender{
  //singleton constructor
  static final TwilioSender _singleton = new TwilioSender._internal();

  factory TwilioSender(){
    return _singleton;
  }

  TwilioSender._internal();

  //methods

  /*
    This method will send a message to number.
    Params:
    message - the message to be sent
    number - the destination phone number in String
  */
  Future<Map> sendMessage(String number, String message) async {
    
    //set variables for later use
    var client = http.Client();
    var url = '${DotEnv().env['TWILIO_BASE_URL']}/Accounts/${DotEnv().env['TWILIO_ACCOUNT_SID']}/Messages.json';

    //make post request to url using client
    try{
      var response = await client.post(url, 
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ' + toAuthCredentials(DotEnv().env['TWILIO_ACCOUNT_SID'], DotEnv().env['TWILIO_AUTH_TOKEN'])
        },
        body: {
          'From': '${DotEnv().env['TWILIO_SENDER_NUM']}',
          'To': number,
          'Body': message
        }
      );
      print(json.decode(response.body));
      return (json.decode(response.body));
    
    } catch(e){
      print(e);
      return ({'Runtime Error': e});

    } finally{
      client.close(); //after all
    }
  }
}