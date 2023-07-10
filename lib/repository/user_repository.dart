import 'crud_repository.dart';
import '../models/user/user_model.dart';

/// The item repository.
///
/// author @KyawZayarLynn
class CrudUser extends CRUDRepository<UserModel> {
  String createQuery() {
    return '''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY NOT NULL,
      role VARCHAR(100),
      name VARCHAR(100),
      email TEXT,
      password TEXT
    )
    ''';
  }

  @override
  Future<int?> create(UserModel data) async {
    final id = await database.insert('user', data.toJson());
    return id;
  }

  @override
  Future<int?> update(id,UserModel data) async {
    final rowsAffected =
        await database.update('user', data.toJson(), where: 'id=?', whereArgs: [id]);
    return rowsAffected;
  }

  @override
  Future<int?> delete(id) async {
    final rowsAffected =
        await database.delete('user', where: 'id=?', whereArgs: [id]);
    return rowsAffected;
  }

  @override
  Future<UserModel?> getById(id) async {
    final List<Map<String, dynamic>> result =
        await database.query('user', where: 'id=?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    }
    return null;
  }

  @override
  Future<List<UserModel>?> list() async {
    final List<Map<String, dynamic>> users = await database.query('user');

    if (users.isNotEmpty) {
      return users.map((map) => UserModel.fromJson(map)).toList();
    }
    return null;
  }
}
