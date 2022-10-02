import 'package:artic/data_classes/User.dart';
import 'package:flutter/material.dart';
import '../data_classes/DatabaseHandler.dart';
import 'package:sqflite/sqflite.dart';

class Model {
  late User _currentUser;
  late Database _db;
  late DatabaseHandler _handler;

  Model() {
    _currentUser =
        User("default email", "default fullName", "default password");
    _handler = DatabaseHandler();
    setDB();
  }
  Future<void> setDB() async {
    _db = await _handler.initializeDB();
  }

  //User methods
  Future<bool> userIsValid(String email, String password) async {
    List<Map> emailList = await _db.rawQuery("SELECT * FROM user WHERE email = '$email'");
    if (emailList.isNotEmpty) {
      String dbPassword = emailList[0]["password"];
      print("userIsValid = true\n");
      return dbPassword == password;
    }
    print("userIsValid = false\n");
    return false;
  }

  Future<void> setCurrentUser(String email) async {
    List<Map<String, Object?>> emailList = await _db.rawQuery("SELECT * FROM user WHERE email = '$email'");
    //List<Map<String, Object?>> courseTest = await _db.rawQuery("SELECT * FROM course WHERE course_title = 'Software Engineering I'");
    //print(courseTest[0]);
    _currentUser = emailList.map((e) => User.fromMap(e)).toList()[0];
    print(_currentUser.toString());
  }

  void addUser(String email, String fullName, String password) {
    _handler.insertUser(User(email, fullName, password), _db);
  }

  Future<bool> emailIsAvailable(String email) async {
    List<Map> emailList = await _db.rawQuery("SELECT * FROM user WHERE email = '$email'");
    return emailList.isEmpty;
  }
  //End of User methods

  //School methods
  Future<List<DropdownMenuItem<String>>> getSchoolNames() async {
    print("starting getSchoolNames()\n");
    List<Map<String, Object?>> schoolNameList = await _db.query('school', columns: ['s_name']);
    //print("contents of schoolNameList: $schoolNameList\n");
    List<Object?> list = schoolNameList.map((e) => e["s_name"]).toList();
    List<DropdownMenuItem<String>> colleges = [];
    for (Object? o in list) {
      String name = o as String;
      colleges.add(DropdownMenuItem(value: name, child: Text(name)));
    }
    print("End of getSchoolNames()\n");
    return colleges;
  }

  Future<List<DropdownMenuItem<String>>> getCourseNames(String collegeName) async {
    print("starting getCourseNames()\n");
    List<Map<String, Object?>> courseNameList = await _db.rawQuery("SELECT course_prefix, course_num FROM school JOIN course ON school.school_id=course.school_id WHERE s_name = \'$collegeName\'");
    //print("contents of schoolNameList: $schoolNameList\n");
    List<Object?> prefixList = courseNameList.map((e) => e["course_prefix"]).toList();
    List<Object?> numList = courseNameList.map((e) => e["course_num"]).toList();
    List<DropdownMenuItem<String>> courses = [];
    for (int i = 0; i < numList.length; i++) {
      String course = prefixList[i] as String;
      course += "-";
      course += numList[i] as String;
      courses.add(DropdownMenuItem(value: course, child: Text(course)));
    }
    print("End of getCourseNames()\n");
    return courses;
  }
  //End of School methods
}
