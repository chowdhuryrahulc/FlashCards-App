import 'package:flashcards/database/2nd_database_helper.dart';
import 'package:flashcards/database/database_helper.dart';
import 'package:flutter/material.dart';

@override
createSet(BuildContext context,
    {String? title, String? description, bool? edit, title? ttl}) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  if (title != null) {
    titleController.text = title;
    // descriptionController.text= description;
  }

  final _formKey = GlobalKey<FormState>();

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
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Form(
            key: _formKey,
            child: Dialog(
                insetPadding: EdgeInsets.all(20),
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 0.0,
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close)),
                      actions: [
                        IconButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submitTitle(context, titleController.text,
                                    descriptionController.text,
                                    editx: edit, ttl: ttl, titleM: title);
                                setState(() {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            icon: Icon(Icons.check))
                      ],
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) => val!.isNotEmpty
                                  ? null
                                  : 'Name Should Not Be Empty',
                              controller: titleController,
                              decoration: InputDecoration(
                                  labelText: "Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  labelText: "Description-optional",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                            ),
                            SizedBox(
                              height: 10,
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
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Term language",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                DropdownButton<String>(
                                  value: Z,
                                  hint: Text('English'),
                                  onChanged: (String? N) {
                                    if (N != null) {
                                      Z = N;
                                    }
                                  },
                                  items: J,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("Definition language"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
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
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                  "In case of missing languages, or if audio does not work you need to install the language."),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text("INSTALL LANGUAGES")),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width / 2) + 10,
                              child: FloatingActionButton.extended(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _submitTitle(
                                          context,
                                          titleController.text,
                                          descriptionController.text,
                                          editx: edit,
                                          ttl: ttl,
                                          titleM: title);
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                  label: Text("ADD CARDS")),
                            ),
                          ],
                        ),
                      ),
                    ))),
          );
        });
      });
}

_submitTitle(BuildContext context, ttleControl, descripControl,
    {bool? editx, title? ttl, String? titleM}) async {
  final DBManager dbManager = DBManager();
  final DBManager2 dbManager2 = DBManager2();
  // title? TTitle;
  List<nd_title> ist = await dbManager2.getnd_TitleList();

  // nd_title? nd_title = [];
  if (editx == null) {
    title ttl = title(name: ttleControl, description: descripControl);
    dbManager.insertTitle(ttl).then((value) => null);
  } else {
    print('FloaTing EditOr ${ttleControl}');
    ttl!.name = ttleControl;
    ttl.description = descripControl;
    // title ttl = title(name: ttleControl, description: descripControl);
    dbManager.updateTitle(ttl).then((value) => null);
    for (int b = 0; b < ist.length - 1; b++) {
      await dbManager2.renameCurrent_setListView(titleM!, ttleControl, ist[b]);
    }
    //! ERROR:- nd_title
  }
}
