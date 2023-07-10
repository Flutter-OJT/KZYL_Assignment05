import 'package:authentications/repository/user_repository.dart';
import 'package:authentications/screens/auth/register.dart';
import 'package:authentications/screens/commons/common_widget.dart';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/prefs/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class LoginScreen extends GetView<LoginService> {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<StorageService>();
    final loginService = Get.find<LoginService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Middleware X TodoList')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text('Sign In or Sign up'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: CommonWidget.inputStyle(placeholder: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty!!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !loginService.passwordVisible,
                      decoration:
                          CommonWidget.passwordStyle(placeholder: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty!!';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: const Text('Sign In'),
                        onPressed: () async {
                          var bytes = utf8.encode(_passwordController.text);
                          var encryptedPassword =
                              sha1.convert(bytes).toString();

                          if (_formkey.currentState!.validate()) {
                            final email = _emailController.text;
                            final password = encryptedPassword;

                            try {
                              final CrudUser userCrud = CrudUser();
                              final userlist = await userCrud.list();
                              final user = userlist!
                                  .firstWhere((user) => user.email == email);

                              if (user.email == email &&
                                  user.password == password) {
                                controller.authService.authenticated = true;

                                await storageService.storage
                                    .write(key: 'useremail', value: user.email);
                                await storageService.storage.write(
                                    key: 'userpassword', value: user.password);
                                await storageService.storage
                                    .write(key: 'username', value: user.name);
                                controller.authService.useremail = email;
                                controller.authService.userpassword = password;
                                controller.authService.username = user.name;
                                if (user.id == 1) {
                                  Get.offNamed('/adminHome');
                                } else {
                                  Get.offNamed('/home');
                                }
                              } else {
                                throw Exception(
                                    'Login Failed : Invalid email or invalid password');
                              }
                            } catch (e) {
                              Get.snackbar('', '',
                                  titleText: const Text(
                                    'Login Form',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  messageText: const Text(
                                    'Login Failed : Invalid email or invalid password',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  snackPosition: SnackPosition.TOP,
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: Colors.red);
                            }
                          }
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.to(() => RegistrationScreen());
                          },
                          child: const Text('Sign Up')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
