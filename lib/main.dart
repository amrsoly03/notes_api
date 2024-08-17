import 'package:flutter/material.dart';
import 'package:notes_api/auth/login.dart';
import 'package:notes_api/auth/signup.dart';
import 'package:notes_api/screens/add_note.dart';
import 'package:notes_api/screens/edit_note.dart';
import 'package:notes_api/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: sharedPref.getString('id') == null ? 'login' : 'home',
      routes: {
        'login': (context) => const Login(),
        'signUp': (context) => const SignUp(),
        'home': (context) => Home(),
        'addNote': (context) => const AddNote(),
        'editNote': (context) => const EditNote(),
      },
    );
  }
}
