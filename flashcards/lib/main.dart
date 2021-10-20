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
  getLoggedInState();
  runApp(MyApp());
}

getLoggedInState() {
  Helperfunctions.getuserLoggedInSharedPreference().then((value) {
    LoggedIn = value;
  });
}

// bool darkx = false;
bool? LoggedIn;
// var char = Charmender();
late SharedPreferences logindata;
late bool newuser;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: LoggedIn != null
          ? LoggedIn!
              ? Firstpage() //!AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
              : google()
          : Container(
              child: Center(
                child: google(),
              ),
            ),
      // google(),
    );
  }
}

// class darktheme extends ChangeNotifier {
//   bool _dark = false;
//   bool get dark => _dark;
//   void change(value) {
//     _dark = value;
//     notifyListeners();
//   }
// }
class Helperfunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";

  static Future<bool> saveuserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool?> getuserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserLoggedInKey);
  }
}
