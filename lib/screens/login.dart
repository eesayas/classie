import '../exports.dart';
import 'package:http/http.dart' as http;

//this class will encapsulate the login screen
class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //This function will login in the user
  Future<String> attemptLogIn(String username, String password) async {
    //encode data to be sent to server
    final String jsonData = json.encode({
      "username": username,
      "password": password,
    });

    //set headers
    final Map<String, String> headers = {"Content-type": "application/json"};

    //send request to server
    var res = await http.post("${DotEnv().env['API_PROXY']}/user/login",
        headers: headers, body: jsonData);

    //extract token from response
    var extractedData = json.decode(res.body) as Map<String, dynamic>;
    var token = extractedData["token"];

    //return it if successful
    if (res.statusCode == 200) return token;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [purpleColor, purpleColorEnd],
          )),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 0),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 70, left: 0, right: 0),
                  child: Text(
                    'classie',
                    style: TextStyle(color: logoWhite, fontSize: 60),
                  ),
                ),

                //THIS IS THE USERNAME INPUT
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(
                        color: mildWhite, fontWeight: FontWeight.w900),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: logoWhite),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: logoWhite),
                    ),
                  ),
                  style:
                      TextStyle(color: logoWhite, fontWeight: FontWeight.w900),
                  keyboardType: TextInputType.text,
                ),

                //THIS IS THE PASSWORD INPUT
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: mildWhite, fontWeight: FontWeight.w900),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: logoWhite),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: logoWhite),
                    ),
                  ),
                  style:
                      TextStyle(color: logoWhite, fontWeight: FontWeight.w900),
                  obscureText: true,
                ),

                //THIS IS THE SIGN IN BUTTON
                Align(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                    child: RaisedButton(
                      onPressed: () async {
                        var username = _usernameController.text;
                        var password = _passwordController.text;
                        var jwt = await attemptLogIn(username, password);

                        if (jwt != null) {
                          //store jwt in local secure storage
                          storage.write(key: "jwt", value: jwt);

                          //then navigate to class live (if live)
                          Navigator.pushNamed(context, '/class-index');
                        } else {
                          // show error dialog if login is unsuccessful
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Login Error"),
                              content:
                                  Text("Something went wrong while logging in"),
                            ),
                          );
                        }
                      },
                      color: logoWhite,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              color: buttonPurple,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ],
            ))),
          ),
        ));
  }
}
