import '../exports.dart';

class LoginScreen extends StatelessWidget {
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
                TextField(
                  decoration: InputDecoration(
                    hintText: "Phone number",
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
                  keyboardType: TextInputType.number,
                ),
                TextField(
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
                Align(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClassIndex())); //go to my classes
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
                Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(TextSpan(
                            text: 'Don’t have an account? ',
                            style: TextStyle(color: mildWhite, fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline))
                            ])),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegisterScreen())); //go to sign up form
                      },
                    ))
              ],
            ))),
          ),
        ));
  }
}
