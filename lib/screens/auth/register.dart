import 'dart:convert';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/user_service/user_service.dart';
import '../../models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';

// ignore: must_be_immutable
class RegistrationScreen extends GetView<LoginService> {
  RegistrationScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  UserService userService = UserService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginService = Get.find<LoginService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Screen'),
      ),
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
                    child: Text('Registration'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty!!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
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
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            loginService.passwordVisible =
                                !loginService.passwordVisible;
                          },
                          child: Icon(
                            loginService.passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
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
                  // TextFormField(
                  //   controller: _roleController,
                  //   keyboardType: TextInputType.visiblePassword,
                  //   decoration: const InputDecoration(
                  //     label: Text('user or admin'),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Role cannot be empty!!';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () async {
                      var bytes = utf8.encode(_passwordController.text);
                      var encryptedPassword = sha1.convert(bytes).toString();

                      if (_formkey.currentState!.validate()) {
                        UserModel newUser = UserModel(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: encryptedPassword,
                          role: 'user',
                        );
                        userService.createUser(newUser);
                        Get.snackbar('', '',
                            titleText: const Text(
                              'Registration',
                              style: TextStyle(color: Colors.white),
                            ),
                            messageText: const Text(
                              'Registration Succeed!!',
                              style: TextStyle(color: Colors.white),
                            ),
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 3),
                            backgroundColor: Colors.green);
                        Get.offNamed('/login');
                      }
                    },
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
