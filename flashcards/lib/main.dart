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
            ? darkThemeData()
            : lightThemeData(),
        darkTheme: darkThemeData(),
        debugShowCheckedModeBanner: false,
        home: Profilepage());
  }

  ThemeData lightThemeData() => ThemeData(
      appBarTheme:
          Theme.of(context).appBarTheme.copyWith(backgroundColor: Colors.blue),
      scaffoldBackgroundColor: Colors.grey[300],
      backgroundColor: Colors.blue,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.white,
          primaryVariant: Colors.green,
          secondaryVariant: Colors.blue),
      textTheme: Theme.of(context).textTheme.copyWith(
            bodyText1: Theme.of(context)
                .textTheme
                .bodyText1!
                .apply(color: Colors.black),
          ),
      primaryColor: Colors.amber,
      popupMenuTheme: Theme.of(context).popupMenuTheme.copyWith(
          color: Colors.white, textStyle: TextStyle(color: Colors.black)),
      iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black));

  ThemeData darkThemeData() => ThemeData(
        // FAB from Red to Blue
        appBarTheme: Theme.of(context)
            .appBarTheme
            .copyWith(backgroundColor: Colors.grey[900]),
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
        // drawerTheme: DrawerTheme.of(context).copyWith(

        // ),
        //! colorSceme.copywith. try different combos.
        primaryColor: Colors.amber,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white, // for ListView headline and subtitle
          secondary: Colors.grey[900], // for Container in ListView
          primaryVariant: Colors.blueGrey[700], // BasicReview container color
          secondaryVariant: Colors.blueGrey[300], // BasicReview container color
        ),
        popupMenuTheme: Theme.of(context).popupMenuTheme.copyWith(
            color: Colors.black, textStyle: TextStyle(color: Colors.white)),
        //! THIS IS TEXTTHEME. NOT COLOR
        // NOT USED
        textTheme: Theme.of(context).textTheme.copyWith(
            headline1: Theme.of(context).textTheme.headline1!.apply(
                  color: Colors.white,
                  // fontSizeDelta:
                )),
      );
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
