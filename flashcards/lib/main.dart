import 'dart:async';
import 'package:flashcards/Modals/Themes.dart';
import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Profilepage.dart';
import 'package:flashcards/database/HeadlineDatabase.dart';
import 'package:flashcards/database/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HeadlineDatabase().getTitleList();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
    ChangeNotifierProvider(
        create: (context) => createSetFutureHeadlineControl()),
    ChangeNotifierProvider(create: (context) => iWhiteBoardReviewControl()),
    ChangeNotifierProvider(create: (_) => darktheme()),
    ChangeNotifierProvider(create: (_) => iSelectDefinationControl()),
    ChangeNotifierProvider(create: (_) => iAudioPlayerControl()),
    ChangeNotifierProvider(create: (_) => gridViewVisibleControl()),
    ChangeNotifierProvider(create: (_) => iMatchControl()),
    ChangeNotifierProvider(create: (_) => pictureBLOBControl()),
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
            ? darkThemeData(context)
            : lightThemeData(context),
        darkTheme: darkThemeData(context),
        debugShowCheckedModeBanner: false,
        home: Profilepage());
  }
}
