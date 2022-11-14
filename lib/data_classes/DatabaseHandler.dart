import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:artic/data_classes/User.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'artic2.db'),
      version: 1,
    );
  }
  /// User methods
  Future<int> insertUser(User user, Database db) async {
    print("inserted into database");
    int result = 0;
    result = await db.insert('user', user.toMap());
    return result;
  }
  /// End of User Methods
}
