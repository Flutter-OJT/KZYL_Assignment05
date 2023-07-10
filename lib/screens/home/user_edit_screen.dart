import 'dart:convert';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/user_service/user_service.dart';
import '../../models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';

class UserEditScreen extends GetView<LoginService> {
  UserEditScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  UserService userService = UserService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Users'),
      ),
      body: ,
    );
  }
}
