import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards/database/google_sign_in.dart';
import 'package:flashcards/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
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
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text("All Cards"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              progressCalender(context);
            },
            child: ListTile(
              leading: Icon(Icons.show_chart),
              title: Text("Progress"),
            ),
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
            onTap: () {
              if (context.read<darktheme>().dark == true) {
                context.read<darktheme>().change(false);
              } else {
                context.read<darktheme>().change(true);
              }
            },
            child: ListTile(
              leading: Icon(Icons.highlight,
                  color: !context.watch<darktheme>().dark
                      ? Colors.grey
                      : Colors.blue),
              title: Text("Toggle Night Theme",
                  style: TextStyle(
                      color: !context.watch<darktheme>().dark
                          ? Colors.black
                          : Colors.blue)),
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

@override
progressCalender(BuildContext context) {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: EdgeInsets.all(20),
              child: Scaffold(
                appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close)),
                    title: Text('Progress'),
                    actions: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
                    ]),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TableCalendar(
                          focusedDay: selectedDay,
                          firstDay: DateTime(1990), //Need update
                          lastDay: DateTime(2990),
                          startingDayOfWeek:
                              StartingDayOfWeek.monday, //Dont need
                          daysOfWeekVisible: true,
                          // Day Changed
                          onDaySelected:
                              (DateTime selectDay, DateTime focusDay) {
                            setState(() {
                              selectedDay = selectDay;
                              focusedDay = focusDay;
                            });
                          },
                          selectedDayPredicate: (DateTime date) {
                            return isSameDay(selectedDay, date);
                          },
                          // To style Calender
                          calendarStyle: CalendarStyle(
                              isTodayHighlighted: true,
                              selectedDecoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.rectangle,
                              ),
                              todayDecoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.rectangle,
                              )),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          )),
                    ),
                    Text('Daily goals compleated: 0'),
                    SizedBox(height: 14),
                    Opacity(
                        opacity: 0.5,
                        child: Text(
                            'The collection of stats started on 10/09/2021')),
                    SizedBox(height: 5)
                  ],
                ),
              ),
            );
          },
        );
      });
}
