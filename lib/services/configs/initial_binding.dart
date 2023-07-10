import 'package:authentications/services/auth/auth_service.dart';
import 'package:authentications/services/prefs/storage_service.dart';
import 'package:get/instance_manager.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(StorageService());
  }
}
