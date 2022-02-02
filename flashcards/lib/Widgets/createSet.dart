import 'package:flashcards/Modals/headlineModal.dart';
import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flashcards/database/HeadlineDatabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

@override
Future createSet(BuildContext context,
    {String? title, String? description, bool? edit, Headlines? ttl}) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Color textColor = Theme.of(context).colorScheme.primary;
  if (title != null) {
    titleController.text = title;
    // descriptionController.text= description;
  }

  Future<Headlines> head;
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
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: textColor),
                              validator: (val) => val!.isNotEmpty
                                  ? null
                                  : 'Name Should Not Be Empty',
                              controller: titleController,
                              decoration: InputDecoration(
                                  labelText: "Name",
                                  labelStyle: TextStyle(color: textColor),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                              style: TextStyle(color: textColor),
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  labelText: "Description-optional",
                                  labelStyle: TextStyle(color: textColor),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("Category",
                                    style: TextStyle(
                                        color: textColor, fontSize: 15)),
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
                                Text("Term language",
                                    style: TextStyle(
                                        color: textColor, fontSize: 15)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                DropdownButton<String>(
                                  value: Z,
                                  hint: Text('English',
                                      style: TextStyle(color: textColor)),
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
                                Text("Definition language",
                                    style: TextStyle(
                                        color: textColor, fontSize: 15)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                DropdownButton<String>(
                                  value: M,
                                  hint: Text('English',
                                      style: TextStyle(color: textColor)),
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
                                  "In case of missing languages, or if audio does not work you need to install the language.",
                                  style: TextStyle(
                                      color: textColor, fontSize: 15)),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text("INSTALL LANGUAGES",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 15))),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width / 2) + 10,
                              child: FloatingActionButton.extended(
                                  backgroundColor: Colors.blue,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _submitTitle(
                                          context,
                                          titleController.text,
                                          descriptionController.text,
                                          editx: edit,
                                          ttl: ttl,
                                          titleM: title);
                                      // print(head.name);
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
    {bool? editx, Headlines? ttl, String? titleM}) async {
  final HeadlineDatabase dbManager = HeadlineDatabase();
  final VocabDatabase dbManager2 = VocabDatabase();
  List<VocabCardModal> ist = await dbManager2.getAllVocabCards();

  if (editx == null) {
    Headlines ttl = Headlines(name: ttleControl, description: descripControl);
    dbManager.insertTitle(ttl).then((value) => null);
    context.read<createSetFutureHeadlineControl>().updateFutureHeadline(ttl);
  } else {
    print('FloaTing EditOr ${ttleControl}');
    ttl!.name = ttleControl;
    ttl.description = descripControl;
    dbManager.updateTitle(ttl).then((value) => null);
    for (int b = 0; b < ist.length - 1; b++) {
      await dbManager2.renameCurrent_setListView(titleM!, ttleControl, ist[b]);
    }
    context.read<createSetFutureHeadlineControl>().updateFutureHeadline(ttl);
  }
}
