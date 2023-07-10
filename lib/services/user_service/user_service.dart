import '../../models/user/user_model.dart';
import 'package:get/get.dart';
import '../../repository/user_repository.dart';

class UserService {
  final CrudUser userCrud = CrudUser();
  RxList<UserModel> userlist = <UserModel>[].obs;

  Future<void> createUser(UserModel newUser) async {
    int? id = await userCrud.create(newUser);
    if (id != null) {
      newUser.id = id;
      userlist.add(newUser);
    }
  }

  Future<void> updateUser(UserModel updatedUser, int id) async {
    updatedUser.id = id;
    await userCrud.update(id, updatedUser);

    int index = userlist.indexWhere((user) => user.id == id);
    if (index != -1) {
      userlist[index].id = id;
      userlist[index].name = updatedUser.name;
      userlist[index].email = updatedUser.email;
      userlist[index].password = updatedUser.password;
      userlist[index].role = updatedUser.role;
      userlist.refresh();
    }
  }

  Future<void> deleteUser(int? id) async {
    if (id != null) {
      await userCrud.delete(id);
      userlist.removeWhere((user) => user.id == id);
    }
  }
}
