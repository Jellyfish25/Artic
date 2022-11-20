// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:artic/data_classes/DatabaseHandler.dart';
import 'package:artic/data_classes/Model.dart';
import 'package:artic/data_classes/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

/*
To begin testing:
1. Start android emulator
2. Type the following command in terminal: run test/model_test.dart
3. Helpful commands while running:
    shift + R: to to reload tests
    c: clear terminal
    q: to quit
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DatabaseHandler handler = DatabaseHandler();
  // Database db = await handler.initializeDB();
  // handler.insertUser(User("email1@email.com", "user1", "password1", -1), db);
  // handler.insertUser(User("email2@email.com", "user2", "password2", -1), db);
  // handler.insertUser(User("email3@email.com", "user3", "password3", -1), db);
  // Model model = Model();

  // variables need to be late (to be initialized then used later on)
  late DatabaseHandler handler;
  late Database db; //note, only thing that sends out error (non breaking)
  late Model model;

  // setUpAll() is a function that runs once before all the tests run. You can think of it as the initState() method.
  setUpAll() async {
    handler = DatabaseHandler();
    db = await handler.initializeDB();
    handler.deleteUser("email1@email.com", db);
    handler.deleteUser("email2@email.com", db);
    handler.deleteUser("email3@email.com", db);
    handler.insertUser(User("email1@email.com", "user1", "password1", -1), db);
    handler.insertUser(User("email2@email.com", "user2", "password2", -1), db);
    handler.insertUser(User("email3@email.com", "user3", "password3", -1), db);

    model = Model();
    // print("VERIFYING IF USER IS ENTERED IN DB: \n");
    // List<Map> emailList = await db
    //     .rawQuery("SELECT * FROM user WHERE email = 'email1@email.com'");
    // print(emailList);
    // print(await model.userIsValid("email1@email.com", "password1"));
    // print("******* END TEST ******\n");
  }

  setUpAll();

  // EXAMPLE OF TEST CASE:
  /*
      test('value should be incremented', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });
   */
  group('getCourseHistory tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getEquivalentCourseHistory tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('removeCourseFromHist tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('addCourseToHist tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('userIsValid tests', () {
    test('Test valid user input', () async {
      expect(await model.userIsValid("email3@email.com", "password3"), true);
    });
    test('', () {});
    test('', () {});
  });
  group('getCurrentUser tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('setCurrentUser tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('addUser tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('removeUser tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('emailIsAvailable tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getSchoolNames tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getSchoolDegrees tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getCourses tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getPlans tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('addPlan tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('removePlan tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('setFavePlan tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getFavePlan tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getFavePlanIndex tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getPlanSchoolName tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getReqs tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getReqNeeded tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getReqMet tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  group('getPossibleMajors tests', () {
    test('', () {});
    test('', () {});
    test('', () {});
  });
  handler.deleteUser("email1@email.com", db);
  handler.deleteUser("email2@email.com", db);
  handler.deleteUser("email3@email.com", db);
}
