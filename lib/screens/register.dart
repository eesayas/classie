import '../exports.dart';

class RegisterScreen extends StatelessWidget {
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
                      EdgeInsets.only(top: 40, bottom: 40, left: 0, right: 0),
                  child: Text(
                    'classie',
                    style: TextStyle(color: logoWhite, fontSize: 60),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Teacher name",
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
                TextField(
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
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
                          'Sign Up',
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
                    padding: EdgeInsets.only(bottom: 40),
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: mildWhite, fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline))
                            ])),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginScreen())); //go to sign in form
                      },
                    ))
              ],
            ))),
          ),
        ));
  }
}
