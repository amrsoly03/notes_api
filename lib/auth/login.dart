import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notes_api/constants.dart';
import 'package:notes_api/func/crud.dart';
import 'package:notes_api/main.dart';
import 'package:notes_api/widgets/custom_text_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> globalKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Crud requests = Crud();

  login() async {
    var response = await requests.postRequest(
        linkLogin,
        ({
          'email': emailController.text,
          'password': passController.text,
        }));
    if (response['status'] == 'success') {
      sharedPref.setString('id', response['data']['id'].toString());
      sharedPref.setString('username', response['data']['username']);
      sharedPref.setString('email', response['data']['email']);
      Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
    } else {
      AwesomeDialog(context: context, title: 'Error').show();
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
                  onPressed: login,
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('signUp');
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
