import 'package:artic/screens/ForgotPassword.dart';
import 'package:artic/screens/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:artic/constants.dart';
import 'package:artic/components/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'HomePage.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  //final _auth = FirebaseAuth.instance;
  String email = ''; // made these '' just to silence errors
  String password = '';

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Sign In',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF007BFF),
                    fontSize: 28.0,
                    fontWeight: FontWeight.w500,
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
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Email Address'),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Password'),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    title: 'Confirm',
                    color: const Color(0xFF1375CF),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });

                      try {
                        final user = email; // filler code until DB is set up
                        /*
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                       */
                        if (user != '') {
                          Navigator.pushNamed(context, HomePage.id);
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    height: 50.0,
                    width: 25.0),
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
                  style: const ButtonStyle(
                      //backgroundColor: MaterialStateProperty.all(Colors.red)
                      ),
                  onPressed: () {
                    Navigator.pushNamed(context, SignupScreen.id);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20.0,
                        color: Color(0xFF007BFF)),
                  ),
                ),
                TextButton(
                    style: const ButtonStyle(
                        //backgroundColor: MaterialStateProperty.all(Colors.red)
                        ),
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPassword.id);
                    },
                    child: const Text('Forgot Password?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20.0,
                          color: Color(0xFF007BFF),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
