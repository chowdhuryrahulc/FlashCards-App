import 'dart:async';
import 'dart:typed_data';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/Profilepage.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flashcards/database/HeadlineDatabase.dart';
import 'package:flashcards/database/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HeadlineDatabase().getTitleList();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
    ChangeNotifierProvider(create: (_) => darktheme()),
    ChangeNotifierProvider(create: (_) => iSelectDefinationControl()),
    ChangeNotifierProvider(create: (_) => iAudioPlayerControl()),
    ChangeNotifierProvider(create: (_) => gridViewVisibleControl()),
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
            ? darkThemeData()
            : lightThemeData(),
        darkTheme: darkThemeData(),
        debugShowCheckedModeBanner: false,
        home: Profilepage());
  }

  ThemeData lightThemeData() => ThemeData(
        appBarTheme: Theme.of(context)
            .appBarTheme
            .copyWith(backgroundColor: Colors.blue),
        scaffoldBackgroundColor: Colors.grey[300],
        backgroundColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.white,
          primaryVariant: Colors.green,
          secondaryVariant: Colors.white,
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
              bodyText1: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .apply(color: Colors.black),
            ),
        drawerTheme: Theme.of(context)
            .drawerTheme
            .copyWith(backgroundColor: Colors.white),
        primaryColor: Colors.amber,
        dividerColor: Colors.black,
        textSelectionTheme: Theme.of(context)
            .textSelectionTheme
            .copyWith(selectionColor: Colors.black),
        dialogBackgroundColor: Colors.black,
        bottomSheetTheme: Theme.of(context)
            .bottomSheetTheme
            .copyWith(backgroundColor: Colors.white),
        floatingActionButtonTheme: Theme.of(context)
            .floatingActionButtonTheme
            .copyWith(backgroundColor: Colors.blue),
        popupMenuTheme: Theme.of(context).popupMenuTheme.copyWith(
            color: Colors.white, textStyle: TextStyle(color: Colors.black)),
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
        scrollbarTheme: Theme.of(context).scrollbarTheme.copyWith(
            thumbColor: MaterialStateProperty.all(Colors.blue),
            trackColor: MaterialStateProperty.all(Colors.lightBlue),
            trackBorderColor: MaterialStateProperty.all(Colors.lightBlue),
            showTrackOnHover: true),
      );

  ThemeData darkThemeData() => ThemeData(
      // FAB from Red to Blue
      appBarTheme: Theme.of(context)
          .appBarTheme
          .copyWith(backgroundColor: Colors.grey[900]),
      scaffoldBackgroundColor: Colors.black,
      backgroundColor: Colors.black,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
      bottomSheetTheme: Theme.of(context)
          .bottomSheetTheme
          .copyWith(backgroundColor: Colors.black),
      floatingActionButtonTheme: Theme.of(context)
          .floatingActionButtonTheme
          .copyWith(backgroundColor: Colors.blue),
      drawerTheme:
          Theme.of(context).drawerTheme.copyWith(backgroundColor: Colors.black),
      //! colorSceme.copywith. try different combos.
      primaryColor: Colors.amber, // Drawer header
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.white, // for ListView headline and subtitle
        secondary: Colors.grey[900], // for Container in ListView
        primaryVariant: Colors.blueGrey[700], // BasicReview container color
        secondaryVariant: Colors.blueGrey[300], // BasicReview container color
      ),
      textSelectionTheme: Theme.of(context)
          .textSelectionTheme
          .copyWith(selectionColor: Colors.blue), // for toggleDarkThemeButtom
      dividerColor: Colors.white,
      popupMenuTheme: Theme.of(context).popupMenuTheme.copyWith(
          color: Colors.black, textStyle: TextStyle(color: Colors.white)),
      scrollbarTheme: Theme.of(context).scrollbarTheme.copyWith(
          thumbColor: MaterialStateProperty.all(Colors.blue),
          trackColor: MaterialStateProperty.all(Colors.lightBlue),
          trackBorderColor: MaterialStateProperty.all(Colors.lightBlue),
          showTrackOnHover: true),
      //! THIS IS TEXTTHEME. NOT COLOR
      // NOT USED
      textTheme: Theme.of(context).textTheme.copyWith(
          bodyText1: Theme.of(context)
              .textTheme
              .bodyText1!
              .apply(color: Colors.white, fontSizeFactor: 10
                  // fontSizeDelta:
                  )),
      dialogBackgroundColor: Colors.black);
}

// Get the data, Put the data
class pictureBLOBControl extends ChangeNotifier {
  Uint8List? uint8list;

  sendPictureUint8List(Uint8List uint8List) {
    uint8list = uint8List;
    print(uint8List);
    notifyListeners();
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

class iMatchControl extends ChangeNotifier {
  int i = 0;
  increment() {
    i++;
    notifyListeners();
  }
}

class gridViewVisibleControl extends ChangeNotifier {
  bool visibleTernaryFAB = true;

  updateVisibleTernaryFAB(bool visible) {
    visibleTernaryFAB = visible;
    notifyListeners();
  }
}

class iSelectDefinationControl extends ChangeNotifier {
  int i = 0;
  increment() {
    i++;
    notifyListeners();
  }
}

class iAudioPlayerControl extends ChangeNotifier {
  int i = 0;
  decrement() {
    if (i != 0) {
      i--;
    }
    notifyListeners();
  }

  increment(List<VocabCardModal>? list) {
    if (i < list!.length - 1) {
      i++;
    }
    notifyListeners();
  }
}

class currentSetX extends ChangeNotifier {
  String? currentSet;
}
