import 'dart:async';
import 'package:flashcards/Profilepage.dart';
import 'package:flashcards/database/database_helper.dart';
import 'package:flashcards/database/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DBManager().getTitleList();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
    ChangeNotifierProvider(create: (_) => darktheme()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: context.watch<darktheme>().dark
            ? ThemeData.dark()
            : ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Profilepage());
  }
}

class darktheme extends ChangeNotifier {
  bool _dark = false;
  bool get dark => _dark;
  change(value) {
    _dark = value;
    notifyListeners();
  }
}

class currentSetX extends ChangeNotifier {
  String? currentSet;
}
