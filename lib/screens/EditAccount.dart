import 'package:artic/components/rounded_button.dart';
import 'package:artic/screens/Overview.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:get/get.dart';
import '../constants.dart';


class EditAccountScreen extends StatefulWidget {
  static const String id = 'edit_account_screen';
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  bool showSpinner = false;
  String email = '';
  String currentPassword = ''; // made these '' just to silence errors
  String newPassword = '';
  String confirmNewPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: const KAppBar(title: "Edit Account"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.email),
                      hintText: 'Example@Example.com',
                      labelText: 'Email Address'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    currentPassword = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.vpn_key),
                      hintText: 'Enter Current Password',
                      labelText: 'Current Password *',
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    newPassword = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.vpn_key),
                      hintText: 'Enter New Password',
                      labelText: 'New Password'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    confirmNewPassword = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.vpn_key_outlined),
                      hintText: 'Confirm New Password',
                      labelText: 'Confirm New Password'),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                RoundedButton(
                    title: 'Update',
                    color: const Color(0xFF1375CF),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });

                      // update user table with newly entered account info in the DB

                    },
                    height: 50.0,
                    width: 250.0),
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle:
                      const TextStyle(color: Colors.blue, fontSize: 20, decoration: TextDecoration.underline)),
                  onPressed: () {
                    Get.to(() => Overview());
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
