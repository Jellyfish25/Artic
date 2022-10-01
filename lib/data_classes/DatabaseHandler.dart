import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:artic/data_classes/User.dart';

// test this by connecting it to the sign up page
class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'artic.db'),
      // onCreate: (database, version) async {
      //   await database.execute(
      //     "CREATE TABLE user (email VARCHAR(30) PRIMARY KEY,fullName VARCHAR(50) NOT NULL,password VARCHAR(30) NOT NULL);",
      //   );
      // },
      version: 1,
    );
  }

  //insert a user to the database
  Future<int> insertUser(User user, Database db) async {
    print("inserted into database");
    int result = 0;
    //final Database db = await initializeDB();
    result = await db.insert('user', user.toMap());
    return result;
  }

  //retrieve from the database
  Future<List<User>> retrieveUsers(Database db) async {
    //final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('user');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  //delete user from the database
  Future<void> deleteUser(int id, Database db) async {
    //final db = await initializeDB();
    await db.delete(
      'user',
      where: "email = ?",
      whereArgs: [id],
    );
  }
}
