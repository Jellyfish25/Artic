import 'package:artic/data_classes/User.dart';
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
    _currentUser = emailList.map((e) => User.fromMap(e)).toList()[0];
    print(_currentUser.toString());
  }

  void addUser(String email, String fullName, String password) {
    DatabaseHandler().insertUser(User(email, fullName, password), _db);
  }

  Future<bool> emailIsAvailable(String email) async {
    List<Map> emailList = await _db.rawQuery("SELECT * FROM user WHERE email = '$email'");
    return emailList.isEmpty;
  }
}
