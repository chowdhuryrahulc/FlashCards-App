import 'dart:async';
import 'package:flashcards/Profilepage.dart';
import 'package:flashcards/views/google.dart';
import 'package:flashcards/database/google_sign_in.dart';
import 'package:flashcards/views/grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/views/Firstpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/drawer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider())
      ],
      child: MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: Profilepage()),
    );
  }
}
