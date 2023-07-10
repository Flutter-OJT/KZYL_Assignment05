import 'package:authentications/screens/configs/page_config.dart';
import 'package:authentications/services/auth/auth_service.dart';
import 'package:authentications/services/configs/initial_binding.dart';
import 'package:authentications/services/prefs/storage_service.dart';
import 'package:authentications/services/entity_service/entity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final entityService = Get.put(EntityService());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await entityService.initialize();
  final StorageService storageService = Get.put(StorageService());
  final AuthService authController = Get.put(AuthService());
  await _checkLoggedUser(storageService, authController);

  runApp(const AuthenticationApp());
}

class AuthenticationApp extends StatelessWidget {
  const AuthenticationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Authentication Example',
      initialBinding: InitialBinding(),
      initialRoute: '/home',
      getPages: PageConfig.pages,
    );
  }
}

Future<void> _checkLoggedUser(storageService, authController) async {
  final String? data = await storageService.storage.read(key: 'user');
  authController.authenticated = data != null;
  authController.username = data ?? "";
  authController.useremail = data ?? "";
  authController.userpassword = data ?? "";
}
