import 'package:get/get.dart';
import '../auth/auth_service.dart';
// import 'package:flutter/material.dart';

class LoginService extends GetxController {
  // final emailController = TextEditingController().obs;
  // final passwordController = TextEditingController().obs;
  // final nameController = TextEditingController().obs;
  // final comfirmpasswordController = TextEditingController().obs;

  final _passwordVisible = false.obs;
  @override
  void onInit() {
    // print('>>> LoginController started');
    super.onInit();
  }

  AuthService get authService => Get.find<AuthService>();
  bool get passwordVisible => _passwordVisible.value;
  set passwordVisible(bool value) => _passwordVisible.value = value;
}
