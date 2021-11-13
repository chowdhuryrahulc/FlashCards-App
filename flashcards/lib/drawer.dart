import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards/database/google_sign_in.dart';
import 'package:flashcards/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class drawer extends StatefulWidget {
  bool dark;
  drawer(this.dark, {Key? key}) : super(key: key);

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName!),
            accountEmail: Text(user.email!),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
              radius: 50,
            ),
          ),
          ListTile(
            trailing: Switch(value: false, onChanged: (changed) {}),
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
          InkWell(
            //TODO color change btw normal and blue
            //TODO cant change state of main.dart
            onTap: () {
              setState(() {
                widget.dark = !widget.dark;
                print(widget.dark);
              });
            },
            child: ListTile(
              leading: Icon(Icons.highlight,
                  color: !widget.dark ? Colors.grey : Colors.blue),
              title: Text("Toggle Night Theme",
                  style: TextStyle(
                      color: !widget.dark ? Colors.black : Colors.blue)),
            ),
          ),
          InkWell(
            onTap: () {
              AppSettings.openSoundSettings();
            },
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.backup),
            title: Text("Backup"),
          ),
          InkWell(
            onTap: () {
              launch('mailto:prabir0712@gmail.com');
            },
            child: ListTile(
              leading: Icon(Icons.mail),
              title: Text("Contact Us"),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('For teachers'),
                      content: Text(
                          'If you are working in education please contact me by email.'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('CLOSE')),
                        TextButton(
                            onPressed: () {
                              launch('mailto:prabir0712@gmail.com?');
                            },
                            child: Text('CONTACT US')),
                      ],
                    );
                  });
            },
            child: ListTile(
              leading: Icon(Icons.school),
              title: Text("For teachers"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.computer),
            title: Text("Create cards on a PC"),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Help"),
          ),
          InkWell(
            onTap: () {
              Share.share(
                  'Cheak out this free flashcards app! https://schools.app');
            },
            child: ListTile(
              leading: Icon(Icons.share),
              title: Text("Share App"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Install Languages"),
          ),
          InkWell(
            onTap: () {
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .logout();
            },
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Sign Out"),
            ),
          ),
        ],
      ),
    );
  }
}


// Drawer drawer(context, AM) {
  // final user = FirebaseAuth.instance.currentUser!;
  // bool changeColor = false;
//  }
