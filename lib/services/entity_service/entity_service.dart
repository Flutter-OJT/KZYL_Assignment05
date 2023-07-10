import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

/// # EntityService
///
/// The entity service
///
/// @author KyawZayarLynn
class EntityService {
  late Database _database;

  /// Empty constructor
  EntityService();

  /// ## initialize
  ///
  /// Initialize the database
  Future<void> initialize() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'user.db');
    _database = await openDatabase(path, version: 1, onCreate: _onDbcreate);

    //insertting admin
    await insertAdmin();
  }

  /// ## _onDbCreate
  ///
  /// Create table on database newly created.
  ///
  /// [Parameters]:
  ///   - db [Database]
  ///   - version [Version]
  Future<void> _onDbcreate(Database db, int version) async {
    // create all tables from the models
    await db.execute(
        'CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY,role VARCHAR(20) , name VARCHAR(20),email TEXT,password TEXT ,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS item (id INTEGER PRIMARY KEY,title VARCHAR(100),description VARCHAR(100))');
  }

  Future<void> insertAdmin() async {
    final admin = {
      'role': 'admin',
      'name': 'KyawZayarLynn',
      'email': 'flutter@.com',
      'password': '1ebe1e984dac863615b81ed12aff0a2c29eca583',//password => kyawzayarlynn992002
    };

    final List<Map<String, dynamic>> result = await _database
        .query('user', where: 'email = ?', whereArgs: [admin['email']]);
    
    if(result.isEmpty){
      await _database.insert('user', admin);
    }
  }

  get database => _database;
}
