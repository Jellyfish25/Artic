import 'package:artic/components/rounded_button.dart';
import 'package:artic/constants.dart';
import 'package:flutter/material.dart';
import '../screens/SignupPage.dart';
import 'Overview.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'forgot_password';
  @override
  _ForgotPassword createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  String email = ''; // made these '' just to silence errors
  String new_password = '';
  String new_password2 = '';
  String security_question = 'placeholder';
  String res = '';

  Future createAlertDialog(BuildContext context){
    TextEditingController security = TextEditingController();

    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text(security_question),
        content: TextField(
          controller: security,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: const Text('Submit'),
            onPressed: (){
              Navigator.of(context).pop(security.text.toString());
            },
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Forgot Password',
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
                    labelText: 'Email Address'),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(

                textAlign: TextAlign.left,
                onChanged: (value2) {
                  new_password = value2;
                },
                decoration: kTextFieldDecoration.copyWith(
                    icon: const Icon(Icons.vpn_key),
                    hintText: 'Enter New Password',
                    labelText: 'Password'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                textAlign: TextAlign.left,
                onChanged: (value3) {
                  new_password2 = value3;
                },
                decoration: kTextFieldDecoration.copyWith(
                    icon: const Icon(Icons.vpn_key_outlined),
                    hintText: 'Re-enter Password',
                    labelText: 'ConfirmPassword'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const SizedBox(
                height: 12.0,
              ),
              RoundedButton(
                  title: 'Reset',
                  color: const Color(0xFF1375CF),
                  onPressed: () async {
                    //TODO: first verify if email is in database select security question/answer
                    createAlertDialog(context).then((onValue){
                      res = onValue;
                      print(res);
                      //TODO: check security question if successful update database
                    });
                    setState(() {});
                    try {
                      final user = email; // filler code until DB is set up
                      /*
                        final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                     */
                      if (user != '') {
                        Navigator.pushNamed(context, Overview.id);
                      }
                      setState(() {});
                    } catch (e) {
                      print(e);
                    }
                  },
                  height: 50.0,
                  width: 250.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
