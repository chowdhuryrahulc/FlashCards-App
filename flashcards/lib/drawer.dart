import 'package:app_settings/app_settings.dart';
import 'package:flashcards/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

Drawer drawer(context) {
  late GoogleSignInAccount A;
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(""
              // A!.displayName ?? ''
              ), //showing null value
          accountEmail: Text(""),
          currentAccountPicture: CircleAvatar(),
        ),
        ListTile(
          trailing: Switch(
              value: false,
              //context.watch<darktheme>()._dark,
              onChanged: (changed) {
                //context.read<darktheme>().change(changed);
                // darkx = changed;
              }),
        ),
        InkWell(
          child: ListTile(
            leading: Icon(Icons.list),
            title: Text("All Cards"),
          ),
        ),
        ListTile(
          leading: Icon(Icons.show_chart),
          title: Text("Progress"),
        ),
        ListTile(
          leading: Icon(Icons.import_export),
          title: Text("Import Cards"),
        ),
        ListTile(
          leading: Icon(Icons.announcement),
          title: Text("Needing Review"),
        ),
        ListTile(
          leading: Icon(Icons.highlight),
          title: Text("Toggle Night Theme"),
        ),
        ListTile(
          leading: IconButton(
              onPressed: () {
                AppSettings.openSoundSettings();
              },
              icon: Icon(Icons.settings)),
          title: Text("Settings"),
        ),
        ListTile(
          leading: Icon(Icons.backup),
          title: Text("Backup"),
        ),
        ListTile(
          leading: Icon(Icons.mail),
          title: Text("Contact Us"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.school),
          title: Text("For teachers"),
        ),
        ListTile(
          leading: Icon(Icons.computer),
          title: Text("Create cards on a PC"),
        ),
        ListTile(
          leading: Icon(Icons.help),
          title: Text("Help"),
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text("Share App"),
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text("Install Languages"),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text("Sign Out"),
        ),
      ],
    ),
  );
}
