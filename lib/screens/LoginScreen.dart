import 'package:artic/components/rounded_button.dart';
import 'package:artic/constants.dart';
import 'package:artic/data_classes/Model.dart';
import 'package:artic/screens/ForgotPassword.dart';
import 'package:artic/screens/Overview.dart';
import 'package:artic/screens/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  final Model model;
  static const String id = 'login_screen';
  const LoginScreen({Key? key, required this.model}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState(model);
}

class _LoginScreenState extends State<LoginScreen> {
  Model model;
  bool showSpinner = false;
  String email = '';
  String password = '';
  bool isValidInfo = true;

  _LoginScreenState(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign In',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF007BFF),
                      fontSize: 28.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    icon: const Icon(Icons.email),
                    hintText: 'Enter Email',
                    labelText: 'Email Address',
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    icon: const Icon(Icons.vpn_key),
                    hintText: 'Enter Password',
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                RoundedButton(
                    title: 'Confirm',
                    color: const Color(0xFF1375CF),
                    onPressed: () async {
                      if (await model.userIsValid(email, password)) {
                        model.setCurrentUser(email);
                        Navigator.pushNamed(context, Overview.id);
                      } else {
                        isValidInfo = false;
                        print("Error: email or password is invalid.");
                        //TODO: make this error message visible from UI
                      }
                      print("IS VALID INFO: $isValidInfo");
                      setState(() {});
                    },
                    height: 50.0,
                    width: 250.0),
                Text(
                  !isValidInfo ? "Error: email or password is invalid." : "",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: const Color(0xFFCD0909),
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'Don\'t have an account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle:
                          const TextStyle(color: Colors.blue, fontSize: 20)),
                  onPressed: () {
                    Navigator.pushNamed(context, SignupScreen.id);
                  },
                  child: const Text('Sign Up'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle:
                          const TextStyle(color: Colors.blue, fontSize: 20)),
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPassword.id);
                  },
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
