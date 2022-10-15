import 'package:artic/data_classes/School.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:artic/data_classes/User.dart';

// test this by connecting it to the sign up page
class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'artic2.db'),
      // onCreate: (database, version) async {
      //   await database.execute(
      //     "CREATE TABLE user (email VARCHAR(30) PRIMARY KEY,fullName VARCHAR(50) NOT NULL,password VARCHAR(30) NOT NULL);",
      //   );
      // },
      version: 1,
    );
  }
  /// User methods
  //insert a user to the database
  Future<int> insertUser(User user, Database db) async {
    print("inserted into database");
    int result = 0;
    result = await db.insert('user', user.toMap());
    return result;
  }

  //retrieve from the database
  Future<List<User>> retrieveUsers(Database db) async {
    final List<Map<String, Object?>> queryResult = await db.query('user');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  //delete user from the database
  Future<void> deleteUser(int id, Database db) async {
    await db.delete(
      'user',
      where: "email = ?",
      whereArgs: [id],
    );
  }
  /// End of User Methods

  ///School Methods
  Future<List<School>> retrieveSchools(Database db) async {
    final List<Map<String, Object?>> queryResult = await db.query('school');
    return queryResult.map((e) => School.fromMap(e)).toList();
  }
  ///End of School Methods
}
