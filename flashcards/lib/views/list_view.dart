import 'package:flashcards/database/database_helper.dart';
import 'package:flashcards/modals/Practice.dart';
import 'package:flashcards/modals/createSet.dart';
import 'package:flashcards/modals/share.dart';
import 'package:flashcards/views/Firstpage.dart';
import 'package:flashcards/views/select_definition.dart';
import 'package:flashcards/views/whiteBoardReview.dart';
import 'package:flutter/material.dart';
import 'BasicReview.dart';
import 'grid_view.dart';

class list_view extends StatefulWidget {
  bool X;
  list_view({Key? key, required this.X}) : super(key: key);

  @override
  _list_viewState createState() => _list_viewState();
}

class _list_viewState extends State<list_view> {
  final DBManager dbManager = DBManager();
  List<title>? titleList;
  bool cardBorderColor = false;

  updateArchiveTitle(title tList) {
    if (tList.archive == 0) {
      setState(() {
        dbManager.updateArchiveTitle(tList, 1);
      });
    } else if (tList.archive == 1) {
      setState(() {
        dbManager.updateArchiveTitle(tList, 0);
      });
    } else {
      setState(() {
        dbManager.updateArchiveTitle(tList, 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textThemeControl = Theme.of(context).colorScheme.primary;
    return FutureBuilder(
        future: dbManager.getTitleList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            titleList = snapshot.data;
            return Scrollbar(
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: titleList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    title ttl = titleList![index];
                    return Visibility(
                      //? TRUE:- Can see
                      //? FALSE:- Cant see
                      visible: (() {
                        if (ttl.archive == 1) {
                          if (widget.X == true) {
                            return true;
                          } else {
                            print('archive true||X false');
                            return false;
                          }
                        } else {
                          return true;
                        }
                      }()),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        height: 150,
                        decoration: BoxDecoration(
                            //? use cardBorder...
                            gradient: LinearGradient(stops: [
                              0.02,
                              0.02
                            ], colors: [
                              Colors.red,
                              Theme.of(context).colorScheme.secondary
                            ]),
                            borderRadius:
                                BorderRadius.all(const Radius.circular(6.0))),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => gridView(
                                        currentSetUsedForDatabaseSearch:
                                            ttl.name)));
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                  child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${ttl.name}",
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: textThemeControl),
                                    ),
                                    Text(
                                      "N cards menorized",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: textThemeControl),
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
                                            createSet(context,
                                                    title: ttl.name,
                                                    description:
                                                        ttl.description,
                                                    edit: edi,
                                                    ttl: ttl)
                                                .then((value) {
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            });
                                          },
                                          child: popUpTitle(Icons.edit, "Edit"),
                                        ),
                                      ),
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return gridView(
                                                      currentSetUsedForDatabaseSearch:
                                                          ttl.name);
                                                }));
                                              },
                                              child: popUpTitle(
                                                  Icons.add, "Add cards"))),
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                share(context);
                                                Navigator.pop(context);
                                              },
                                              child: popUpTitle(
                                                  Icons.share, "Share"))),
                                      PopupMenuItem(
                                          child: InkWell(
                                              onTap: () {
                                                updateArchiveTitle(ttl);
                                              },
                                              child: popUpTitle(
                                                  Icons.archive, "Archive"))),
                                      PopupMenuItem(
                                          child: popUpTitle(Icons.import_export,
                                              "Export Cards")),
                                      PopupMenuItem(
                                          child: popUpTitle(
                                              Icons.style, "Merge sets")),
                                      PopupMenuItem(
                                          child: popUpTitle(Icons.move_to_inbox,
                                              "Move Cards")),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.delete_forever,
                                              color: Colors.red,
                                            ),
                                            Text(" Remove"),
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
                                                          BasicReview(
                                                              currentSetUsedForDatabaseSearch:
                                                                  ttl.name)));
                                            },
                                            child: Text("REVIEW",
                                                style: TextStyle(
                                                    color: Colors.blue)),
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty
                                                    .all(RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
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
                                            Practice(context,
                                                cardName: ttl.name);
                                          },
                                          child: Text("PRACTICE",
                                              style: TextStyle(
                                                  color: Colors.blue)),
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
                                        share(context);
                                      },
                                      icon: Icon(Icons.share)))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
          return Container();
        });
  }
}

Row popUpTitle(IconData icon, String tileName, {Color? iconColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(icon),
      Text(
        " $tileName",
      ),
    ],
  );
}
