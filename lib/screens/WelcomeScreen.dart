import 'package:artic/screens/Overview.dart';
import 'package:artic/screens/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artic/Screens/HowDoIUseThisApp.dart';
import '../screens/SignupPage.dart';
import 'LoginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          toolbarHeight: 120,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Column(
            children: [
              Text(
                'ARTIC',
                style: GoogleFonts.roboto(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 64,
                  color: const Color(0xff1375CF),
                ),
              ),
              Text(
                'A Major Exploring Tool',
                style: GoogleFonts.roboto(
                  height: 0.7,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: const Color(0xff1375CF),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Material(
                borderRadius: BorderRadius.circular(101),
                elevation: 5,
                child: const CircleAvatar(
                  backgroundImage: AssetImage('images/IceCube.png'),
                  radius: 100,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 180),
            MaterialButton(
              minWidth: 350.0,
              color: const Color(0xff1375CF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              onPressed: () {
                Navigator.pushNamed(context, SignupScreen.id);
              },
              child: Text(
                'Join now',
                style: GoogleFonts.roboto(
                  height: 0.7,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Text(
                  'Sign In',
                  style: GoogleFonts.roboto(
                    height: 0.7,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: const Color(0xFF007BFF),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 13),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HowDoIUseThisApp.id);
              },
              child: Text(
                'How do I use this app?',
                style: GoogleFonts.roboto(
                  height: 0.7,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                  color: const Color(0xFF007BFF),
                ),
              ),
            ),
          ],
        ));
    //return const Text("welcome screen");
  }
}
