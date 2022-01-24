import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Widgets/progressCalender.dart';
import 'package:flashcards/database/google_sign_in.dart';
import 'package:flashcards/main.dart';
import 'package:flashcards/views/AllCards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class drawer extends StatefulWidget {
  drawer({Key? key}) : super(key: key);

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
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AllSet()));
            },
            child: drawerListTile(Icons.list, "All Cards"),
          ),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                progressCalender(context);
              },
              child: drawerListTile(Icons.show_chart, "Progress")),
          drawerListTile(Icons.import_export, "Import Cards"),
          drawerListTile(Icons.announcement, "Needing Review"),
          InkWell(
            onTap: () {
              if (context.read<darktheme>().dark == true) {
                context.read<darktheme>().change(false);
              } else {
                context.read<darktheme>().change(true);
              }
            },
            child: ListTile(
              leading: Icon(Icons.highlight,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
              title: Text("Toggle Night Theme",
                  style: TextStyle(
                      fontSize: 15,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor)),
            ),
          ),
          InkWell(
              onTap: () {
                AppSettings.openSoundSettings();
              },
              child: drawerListTile(Icons.settings, "Settings")),
          drawerListTile(Icons.backup, "Backup"),
          InkWell(
            onTap: () {
              launch('mailto:prabir0712@gmail.com');
            },
            child: drawerListTile(Icons.mail, "Contact Us"),
          ),
          Divider(),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('For teachers',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary)),
                        content: Text(
                            'If you are working in education please contact me by email.',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary)),
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
              child: drawerListTile(Icons.school, "For teachers")),
          drawerListTile(Icons.computer, "Create cards on a PC"),
          drawerListTile(Icons.help, "Help"),
          InkWell(
              onTap: () {
                Share.share(
                    'Cheak out this free flashcards app! https://schools.app');
              },
              child: drawerListTile(Icons.share, "Share App")),
          drawerListTile(Icons.language, "Install Languages"),
          InkWell(
              onTap: () {
                Provider.of<GoogleSignInProvider>(context, listen: false)
                    .logout();
              },
              child: drawerListTile(Icons.account_circle, "Sign Out")),
        ],
      ),
    );
  }

  ListTile drawerListTile(IconData icon, String title) {
    return ListTile(
        leading: Icon(icon, color: Theme.of(context).iconTheme.color),
        title: Text(title,
            style: TextStyle(
                fontSize: 15, color: Theme.of(context).colorScheme.primary)));
  }
}
