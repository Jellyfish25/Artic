import 'package:artic/components/rounded_button.dart';
import 'package:artic/data_classes/Model.dart';
import 'package:artic/data_classes/User.dart';
import 'package:artic/screens/LoginScreen.dart';
import 'package:artic/screens/Overview.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';
import '../data_classes/DatabaseHandler.dart';
import '../screens/LoginScreen.dart';
import '../data_classes/DatabaseHandler.dart';

class SignupScreen extends StatefulWidget {
  final Model model;
  static const String id = 'sign_up_screen';

  const SignupScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState(model);
}

class _SignupScreenState extends State<SignupScreen> {
  Model model;
  late DatabaseHandler dbHandler;
  bool showSpinner = false;
  String fullName = ''; // made these '' just to silence errors
  String email = '';
  String password = ''; // made these '' just to silence errors
  String confirmPassword = '';

  _SignupScreenState(this.model);

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
                    'Sign Up',
                    textAlign: TextAlign.start,
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
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    fullName = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.assignment_ind),
                      hintText: 'Jane Doe',
                      labelText: 'Full Name'),
                ),
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
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.vpn_key),
                      hintText: 'Enter a Password',
                      labelText: 'Password'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.vpn_key_outlined),
                      hintText: 'Confirm Password',
                      labelText: 'Confirm Password'),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                RoundedButton(
                    title: 'Confirm',
                    color: const Color(0xFF1375CF),
                    onPressed: () async {
                      if (password == confirmPassword &&
                          !model.emailIsUsed(email)) {
                        //model.addUser(User(email, fullName, password));
                        dbHandler = DatabaseHandler();
                        User currentUser = User(email, fullName, password);
                        dbHandler.insertUser(currentUser);
                        List<User> dbList = await dbHandler.retrieveUsers();

                        final Database db =
                            await DatabaseHandler().initializeDB();
                        final List<Map<String, Object?>> swag =
                            await db.query('plan');
                        swag.forEach((row) => print(row));

                        for (User x in dbList) {
                          print(x.toString());
                        }
                        Navigator.pushNamed(context, Overview.id);
                      } else {
                        // TODO: add error response for invalid user info
                      }
                      // setState(() {
                      //   showSpinner = true;
                      // });
                      //
                      // try {
                      //   final user = email; // filler code until DB is set up
                      //   /*
                      // final user = await _auth.signInWithEmailAndPassword(
                      //     email: email, password: password);
                      //  */
                      //   if (user != '') {
                      //     Navigator.pushNamed(context, Overview.id);
                      //   }
                      //
                      //   setState(() {
                      //     showSpinner = false;
                      //   });
                      // } catch (e) {
                      //   print(e);
                      // }
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
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
