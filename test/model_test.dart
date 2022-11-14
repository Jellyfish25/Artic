// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:artic/data_classes/DatabaseHandler.dart';
import 'package:artic/data_classes/Model.dart';
import 'package:artic/data_classes/User.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  DatabaseHandler handler = DatabaseHandler();
  Database db = await handler.initializeDB();
  handler.insertUser(User("email1@email.com", "user1", "password1", -1), db);
  handler.insertUser(User("email2@email.com", "user2", "password2", -1), db);
  handler.insertUser(User("email3@email.com", "user3", "password3", -1), db);
  Model model = Model();
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
    test('', () {});
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
