import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_api/constants.dart';
import 'package:notes_api/func/crud.dart';
import 'package:notes_api/widgets/custom_text_form.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> globalKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Crud requests = Crud();

  signUp() async {
    var response = await requests.postRequest(linkSignUp, {
      'username': nameController.text,
      'email': emailController.text,
      'password': passController.text,
    });
    if (response['status'] == 'success') {
      Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
    } else {
      log('sign up fail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              Image.asset(
                'img/note-2389227_960_720.webp',
                height: 200,
              ),
              const SizedBox(height: 15),
              CustomTextForm(
                hint: 'username',
                controller: nameController,
              ),
              const SizedBox(height: 15),
              CustomTextForm(
                hint: 'email',
                controller: emailController,
              ),
              const SizedBox(height: 15),
              CustomTextForm(
                hint: 'password',
                controller: passController,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: ElevatedButton(
                  onPressed: signUp,
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: const Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('Login');
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
