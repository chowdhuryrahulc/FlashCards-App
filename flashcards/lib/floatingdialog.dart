import 'package:flutter/material.dart';

Future<dynamic> floatingdialog(BuildContext context) {
  String? Z;
  String? M;

  const Y = <String>[
    'English',
    'Arabic',
    'Bangla',
    'Bosnian',
    'Catalan',
    'Czech'
  ];
  final List<DropdownMenuItem<String>> J = Y
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  return showDialog(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      //?title,content
      contentPadding: EdgeInsets.all(10),
      children: [
        TextField(
          decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        TextField(
          decoration: InputDecoration(
              labelText: "Description-optional",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
        Row(
          children: [
            Text("Category"),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.access_alarm),
            )
          ],
        ),
        Text("Term language"),
        DropdownButton<String>(
          //!drop down
          value: Z,
          hint: Text('English'),
          onChanged: (String? N) {
            if (N != null) {
              Z = N;
            }
          },
          items: J,
        ),
        Text("Definition language"),
        DropdownButton<String>(
          value: M,
          hint: Text('English'),
          onChanged: (String? N1) {
            if (N1 != null) {
              M = N1;
            }
          },
          items: J,
        ),
        Text(
            "In case of missing languages, or if audio does not work you need to install the language."),
        TextButton(onPressed: () {}, child: Text("INSTALL LANGUAGES")),
        FloatingActionButton.extended(
            onPressed: () {}, label: Text("ADD CARDS")),
      ],
    ),
  );
}
