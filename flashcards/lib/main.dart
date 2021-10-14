import 'dart:async';
import 'package:flashcards/google.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/views/allset.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
// import 'class.dart';
import 'package:flashcards/drawer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => darktheme()),
  ], child: MyApp()));
}

// bool darkx = false;
bool LoggedIn = false;
// var char = Charmender();
late SharedPreferences logindata;
late bool newuser;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<darktheme>().dark
          ? ThemeData.dark()
          : ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: google(),
    );
  }
}
