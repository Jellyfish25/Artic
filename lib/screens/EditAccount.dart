import 'package:artic/components/rounded_button.dart';
import 'package:artic/constants.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'Overview.dart';
import 'package:artic/data_classes/Model.dart';

class EditAcc extends StatefulWidget {
  final Model model;
  static const String id = 'EditAccount';

  const EditAcc({Key? key, required this.model}) : super(key: key);

  @override
 State<EditAcc> createState() => _EditAccState(model);
}

class _EditAccState extends State<EditAcc> {

  Model model;
  String email = ''; // made these '' just to silence errors
  String newPassword = '';
  String newPassword2 = '';
  String securityQuestion = 'What is your favorite trumpet?';
  String res = '';
  _EditAccState(this.model);

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
      appBar: KAppBar(title: 'Edit Account', model: model),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 30.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change Password',
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
                height: 30.0,
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
                height: 12.0,
              ),
              RoundedButton(
                  title: 'Reset Password',
                  color: const Color(0xFF1375CF),
                  onPressed: () async {
                    if((newPassword == newPassword2) && (newPassword2 != '')) {
                      createAlertDialog(context).then((onValue){
                        res = onValue;
                        if(model.checkSecurityAnswer(res)) {
                          model.updateUserPassword(model.getCurrentUser(), newPassword2);
                          Navigator.pushNamed(context, Overview.id);
                        }
                        else {
                          showAlertDialog(context);
                        }
                        //TODO: check security question if successful update database
                      });
                    }
                    setState(() {});
                  },
                  height: 50.0,
                  width: 250.0),
            ],
          ),
        ),
      ),
      drawer: getKNavBar(model),
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
    content: const Text("Your Answer is Not Correct"),
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