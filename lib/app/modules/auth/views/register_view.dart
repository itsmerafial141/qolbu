import 'package:flutter/material.dart';
import 'package:qolbu/app/modules/auth/controllers/register_controller.dart';
import 'package:qolbu/app/modules/auth/views/auth_view.dart';

class RegisterView extends AuthView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RegisterPage')),
      body: SafeArea(
        child: Text('RegisterController'),
      ),
    );
  }
}
