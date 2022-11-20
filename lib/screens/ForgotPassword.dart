import 'package:artic/components/rounded_button.dart';
import 'package:artic/constants.dart';
import 'package:flutter/material.dart';
import '../screens/SignupPage.dart';
import 'Overview.dart';
import '../data_classes/Model.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'forgot_password';
  final Model model;

  const ForgotPassword({Key? key, required this.model}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPassword(model);
}

class _ForgotPassword extends State<ForgotPassword> {
  Model model;
  String email = ''; // made these '' just to silence errors
  String newPassword = '';
  String newPassword2 = '';
  String securityQuestion = 'What is your favorite trumpet?';
  String res = '';
  _ForgotPassword(this.model);

  Future createAlertDialog(BuildContext context){
    TextEditingController security = TextEditingController();

    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text(securityQuestion),
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
                obscureText: true,
                textAlign: TextAlign.left,
                onChanged: (value2) {
                  newPassword = value2;
                  setState(() {});
                },
                decoration: kTextFieldDecoration.copyWith(
                    icon: const Icon(Icons.vpn_key),
                    hintText: 'Enter New Password',
                    labelText: 'Password',
                    errorText: newPassword == ''
                        ? null
                        : newPassword.length >= 5
                        ? null
                        : "Error: Password needs to contain 5 characters"
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                onChanged: (value3) {
                  newPassword2 = value3;
                  setState(() {});
                },
                decoration: kTextFieldDecoration.copyWith(
                    icon: const Icon(Icons.vpn_key_outlined),
                    hintText: 'Re-enter Password',
                    labelText: 'ConfirmPassword',
                    errorText: newPassword2 == ''
                        ? null
                        : newPassword.length < 5
                        ? null
                        : newPassword2 == newPassword
                        ? null
                        : "Error: Password does not match"),
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
                    if(!(await model.emailIsAvailable(email))) {
                      model.setCurrentUser(email);
                      if((newPassword == newPassword2) && (newPassword2 != '')) {
                        createAlertDialog(context).then((onValue) {
                          res = onValue;
                          if((model.checkSecurityAnswer(res))) {
                            model.updateUserPassword(email, newPassword2);
                            print(model.getCurrentUser());
                            Navigator.pushNamed(context, Overview.id);
                          }
                          else {
                            showAlertDialog(context);
                          }
                          //TODO: check security question if successful update database
                        });
                      }
                    }

                    setState(() {});
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

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error"),
    content: const Text("Either the email is invalid or your answer is not correct"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
