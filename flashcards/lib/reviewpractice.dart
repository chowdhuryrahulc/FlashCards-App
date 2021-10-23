import 'dart:ui';

import 'package:flashcards/database/database_helper.dart';
import 'package:flashcards/views/Firstpage.dart';
import 'package:flashcards/writeexample.dart';
import 'package:flutter/material.dart';

import 'card.dart';

class reviewpractice extends StatefulWidget {
  const reviewpractice({
    Key? key,
    // required this.litems,
  }) : super(key: key);

  // final List<String> litems;

  @override
  State<reviewpractice> createState() => _reviewpracticeState();
}

class _reviewpracticeState extends State<reviewpractice> {
  final DBManager dbManager = DBManager();
  List<title>? titleList;
  // title? ttle;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dbManager.getTitleList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            titleList = snapshot.data;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: titleList!.length,
                itemBuilder: (BuildContext context, int index) {
                  title ttl = titleList![index];
                  return SizedBox(
                    height: 150,
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                              child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              children: [
                                Text(
                                  "${ttl.name}",
                                  style: TextStyle(fontSize: 35),
                                ),
                                Text(
                                  "N cards menorized",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          )),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: PopupMenuButton(
                                  itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    child: InkWell(
                                      onTap: () {
                                        bool? edi = true;
                                        floatingdialog(context,
                                                title: ttl.name,
                                                description: ttl.description,
                                                edit: edi,
                                                ttl: ttl)
                                            .then((value) {
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        });
                                        // Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit),
                                          Text("Edit"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                      child: Row(
                                    children: [
                                      Icon(Icons.add),
                                      Text("Add cards"),
                                    ],
                                  )),
                                  PopupMenuItem(
                                      child: Row(
                                    children: [
                                      Icon(Icons.share),
                                      Text("Share"),
                                    ],
                                  )),
                                  PopupMenuItem(
                                      child: Row(
                                    children: [
                                      Icon(Icons.archive),
                                      Text("Archive"),
                                    ],
                                  )),
                                  PopupMenuItem(
                                      child: Row(
                                    children: [
                                      Icon(Icons.import_export),
                                      Text("Export Cards"),
                                    ],
                                  )),
                                  PopupMenuItem(
                                      child: Row(
                                    children: [
                                      Icon(Icons.style),
                                      Text("Merge sets"),
                                    ],
                                  )),
                                  PopupMenuItem(
                                      child: Row(
                                    children: [
                                      Icon(Icons.move_to_inbox),
                                      Text("Move Cards"),
                                    ],
                                  )),
                                  PopupMenuItem(
                                      child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        dbManager.deleteTitle(ttl.id!);
                                        titleList!.removeAt(index);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        ),
                                        Text("Remove"),
                                      ],
                                    ),
                                  )),
                                ];
                              })),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 100,
                                      height: 35,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Insidepage()));
                                        },
                                        child: Text("REVIEW"),
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.0)))),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    height: 35,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => write()));
                                      },
                                      child: Text("PRACTICE"),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0)))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Dialog(
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.7,
                                                      horizontal: 20),
                                              child: Scaffold(
                                                appBar: AppBar(
                                                  leading: IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(Icons.close)),
                                                  title: Text('Share - Beta'),
                                                ),
                                                body: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      FloatingActionButton
                                                          .extended(
                                                              onPressed: () {},
                                                              label: SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2,
                                                                child: Text(
                                                                  "GENERATE SHARE LINK",
                                                                  // style: TextStyle(
                                                                  //     fontSize:
                                                                  //         14
                                                                  // ),
                                                                ),
                                                              )),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Pro: 7 day link expiration",
                                                          ),
                                                          Switch(
                                                              value: false,
                                                              onChanged:
                                                                  (changed) {}),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Opacity(
                                                            opacity: 0.5,
                                                            child: Text(
                                                                "* The expiration of the link is 3 days"),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                  },
                                  icon: Icon(Icons.share)))
                        ],
                      ),
                    ),
                  );
                });
          }
          return CircularProgressIndicator();
        });
  }
}
