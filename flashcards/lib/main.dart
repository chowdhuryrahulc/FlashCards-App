import 'dart:async';
import 'package:flashcards/google.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/views/allset.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'class.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

bool darkx = true;
bool LoggedIn = false;
var char = Charmender();
late SharedPreferences logindata;
late bool newuser;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: google(),
    );
  }
}
