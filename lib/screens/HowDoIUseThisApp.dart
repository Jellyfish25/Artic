import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HowDoIUseThisApp extends StatelessWidget {
  static const String id = 'how_do_i_use_this_app';

  static const List<String> cardTitles = [
    'The Basics',
    'Personalized Plans',
    'Automatic Articulation',
    'Making a Plan',
    'Track Your Progress',
    'Find the Best Plan for You',
    'Explore the Possibilities'
  ];

  static const List<IconData> icons = [
    CupertinoIcons.book_circle_fill,
    CupertinoIcons.person_crop_circle_fill,
    Icons.school,
    CupertinoIcons.create_solid,
    CupertinoIcons.star_circle_fill,
    CupertinoIcons.arrow_right_arrow_left_circle_fill,
    CupertinoIcons.search_circle_fill
  ];

  static const List<String> tutorialText = [
    'ARTIC is aimed at letting college students know exactly how many more '
        'courses they must take to achieve a particular degree at a particular school.',

    'To get the most out of ARTIC, start by entering the courses you’ve completed into'
        ' your Course History.\n\nThat way, any course requirements you’ve already satisfied'
        ' for a degree will be removed from the list.',

    'ARTIC automatically translates your community college courses into their equivalent'
        ' university courses based on publicly-available articulation information.',

    'Select the college you’re currently enrolled in, the college you want to get the'
        ' degree from, and the degree you want to get.\n\nWhen your Plan is generated,'
        ' you’ll see what required courses you’ve already done and a list of remaining'
        ' courses to finish the degree.',

    'You can return to Plans you’ve created at any time. Select the star to favorite'
        ' a Plan and track your progress on the Overview page.',

    'Use the Compare Plans feature to get a closer look at two plans to see their'
        ' differences.\n\nThis will give you course requirements for both'
        ' degrees and the remaining courses for each one after'
        ' applying your Course History.',

    'If you’re unsure of what degrees are out there, use Explore Majors to search'
        ' colleges for degrees by keyword.'
  ];

  const HowDoIUseThisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          if(index % 2 == 0) {
            return _buildCarousel(context, index ~/ 2);
          }
          else {
            return Divider();
          }
        },
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 50),
        Text(
          'How Do I Use This App?',
          style: GoogleFonts.roboto(
            height: 0.7,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: const Color(0xff1375CF),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 500.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.8),
            itemCount: 7,
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int carouselIndex, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(1, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                cardTitles[itemIndex],
                style: GoogleFonts.roboto(
                  height: 1.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: const Color(0xff1375CF),
                ),
              ),
            ),
            Icon(
              icons[itemIndex],
              size: 150.0,
              color: const Color(0xff1375CF),
            ),
            //const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0, bottom: 10.0),
              child: Text(
                tutorialText[itemIndex],
                style: GoogleFonts.roboto(
                  height: 1.1,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}