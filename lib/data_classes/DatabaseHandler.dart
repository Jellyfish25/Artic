import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:artic/data_classes/User.dart';

// test this by connecting it to the sign up page
class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'artic2.db'),
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

  //delete user from the database
  Future<void> deleteUser(String email, Database db) async {
    await db.delete(
      'user',
      where: "email = ?",
      whereArgs: [email],
    );
  }
  /// End of User Methods
}
