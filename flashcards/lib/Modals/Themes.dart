import 'package:flutter/material.dart';

ThemeData lightThemeData(context) => ThemeData(
      appBarTheme:
          Theme.of(context).appBarTheme.copyWith(backgroundColor: Colors.blue),
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
      drawerTheme:
          Theme.of(context).drawerTheme.copyWith(backgroundColor: Colors.white),
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

ThemeData darkThemeData(context) => ThemeData(
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