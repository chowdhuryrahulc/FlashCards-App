import 'package:flashcards/Modals/headlineModal.dart';
import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Modals/smallWidgets.dart';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/Widgets/Practice.dart';
import 'package:flashcards/Widgets/createSet.dart';
import 'package:flashcards/Widgets/share.dart';
import 'package:flashcards/database/HeadlineDatabase.dart';
import 'package:flashcards/Widgets/drawer.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'BasicReview.dart';
import 'grid_view.dart';

GoogleSignIn sign = GoogleSignIn();
Headlines? titl;

class list_view extends StatefulWidget {
  GoogleSignInAccount? googleAccount;
  list_view({Key? key, this.googleAccount}) : super(key: key);

  @override
  _list_viewState createState() => _list_viewState();
}

class _list_viewState extends State<list_view> {
  bool checkBoxToggle = false;
  final HeadlineDatabase dbManager = HeadlineDatabase();
  final VocabDatabase vocabDatabase = VocabDatabase();
  List<VocabCardModal>? vocabCardModalList;
  List<Headlines>? titleList;
  bool cardBorderColor = false;

  updateArchiveTitle(Headlines tList) {
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
    Headlines? head = context.watch<createSetFutureHeadlineControl>().headline;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () async {
                await launch(
                    "https://github.com/chowdhuryrahulc/Privacy-Policy");
              },
              icon: Icon(Icons.help_outline_rounded)),
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(child: Text("Review Settings")),
              PopupMenuItem(
                child: CheckboxListTile(
                    activeColor: Colors.blueGrey,
                    checkColor: Colors.amber,
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "Display Archived",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    value: checkBoxToggle,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          checkBoxToggle = value;
                          Navigator.pop(context);
                        });
                      }
                    }),
              )
            ];
          })
        ],
      ),
      drawer: drawer(),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: FutureBuilder(
            future: dbManager.getTitleList(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                titleList = snapshot.data;
                if (titleList!.length != 0) {
                  return Column(children: [
                    Container(
                        height: 140,
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        color: Theme.of(context).colorScheme.secondary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              //! padding
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.grey),
                              ),
                              child: ListTile(
                                leading: Text(
                                  'All Sets',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 130,
                                    height: 35,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BasicReview()));
                                      },
                                      child: Text("REVIEW ALL",
                                          style: TextStyle(color: Colors.blue)),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0)))),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: 130,
                                  height: 35,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Practice(context);
                                    },
                                    child: Text("PRACTICE ALL",
                                        style: TextStyle(color: Colors.blue)),
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
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Scrollbar(
                        child: ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: titleList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Headlines ttl = titleList![index];
                              return Visibility(
                                //? TRUE:- Can see
                                //? FALSE:- Cant see
                                visible: (() {
                                  if (ttl.archive == 1) {
                                    if (checkBoxToggle == true) {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  } else {
                                    return true;
                                  }
                                }()),
                                child: Container(
                                  key: Key('listViewContainerKey'),
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  padding: EdgeInsets.only(left: 4),
                                  height: 150,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(stops: [
                                        0.02,
                                        0.02
                                      ], colors: [
                                        ttl.archive == 1
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.blue,
                                        Theme.of(context).colorScheme.secondary
                                      ]),
                                      borderRadius: BorderRadius.all(
                                          const Radius.circular(6.0))),
                                  child: InkWell(
                                    splashColor: Colors.grey[600],
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => gridView(
                                                  currentSetUsedForDatabaseSearch:
                                                      ttl.name))).then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${ttl.name}",
                                                style: TextStyle(
                                                    fontSize: 35,
                                                    color: textThemeControl),
                                              ),
                                              Text(
                                                " N cards menorized",
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
                                            child: PopupMenuButton(itemBuilder:
                                                (BuildContext context) {
                                              return [
                                                PopupMenuItem(
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      bool? edi = true;
                                                      createSet(context,
                                                          title: ttl.name,
                                                          description:
                                                              ttl.description,
                                                          edit: edi,
                                                          ttl: ttl);
                                                    },
                                                    child: popUpTitle(
                                                        Icons.edit, "Edit"),
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return gridView(
                                                                currentSetUsedForDatabaseSearch:
                                                                    ttl.name);
                                                          }));
                                                        },
                                                        child: popUpTitle(
                                                            Icons.add,
                                                            "Add cards"))),
                                                PopupMenuItem(
                                                    child: InkWell(
                                                        onTap: () {
                                                          share(context);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: popUpTitle(
                                                            Icons.share,
                                                            "Share"))),
                                                PopupMenuItem(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          updateArchiveTitle(
                                                              ttl);
                                                        },
                                                        child: popUpTitle(
                                                            Icons.archive,
                                                            "Archive"))),
                                                PopupMenuItem(
                                                    child: popUpTitle(
                                                        Icons.import_export,
                                                        "Export Cards")),
                                                PopupMenuItem(
                                                    child: popUpTitle(
                                                        Icons.style,
                                                        "Merge sets")),
                                                PopupMenuItem(
                                                    child: popUpTitle(
                                                        Icons.move_to_inbox,
                                                        "Move Cards")),
                                                PopupMenuItem(
                                                    child: InkWell(
                                                  onTap: () async {
                                                    // setState(() async {
                                                    await dbManager
                                                        .deleteTitle(ttl.id!)
                                                        .then((value) {
                                                      titleList!
                                                          .removeAt(index);
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    });
                                                    // });
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    width: 100,
                                                    height: 35,
                                                    child: FutureBuilder(
                                                        future: vocabDatabase
                                                            .getVocabCardsusingCurrentSet(
                                                                ttl.name),
                                                        builder: (context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            vocabCardModalList =
                                                                snapshot.data;
                                                            if (vocabCardModalList!
                                                                    .length !=
                                                                0) {
                                                              return OutlinedButton(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              BasicReview(currentSetUsedForDatabaseSearch: ttl.name)));
                                                                },
                                                                child: Text(
                                                                    "REVIEW",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue)),
                                                                style: ButtonStyle(
                                                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(40.0)))),
                                                              );
                                                            } else {
                                                              return addCardsButton(
                                                                  ttl);
                                                            }
                                                          } else {
                                                            return addCardsButton(
                                                                ttl);
                                                          }
                                                        })),
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
                                                            color:
                                                                Colors.blue)),
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
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
                      ),
                    )
                  ]);
                } else {
                  return createYourFirstSetListView();
                }
              } else {
                return createYourFirstSetListView();
              }
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("CREATE SET"),
        heroTag: 'terminator',
        icon: Icon(Icons.add),
        onPressed: () {
          createSet(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  addCardsButton(Headlines ttl) {
    return FloatingActionButton.extended(
      elevation: 0,
      heroTag: ttl.id,
      onPressed: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        gridView(currentSetUsedForDatabaseSearch: ttl.name)))
            .then((value) {
          setState(() {});
        });
      },
      label: Text('ADD CARDS'),
      // icon: Icon(Icons.add),
    );
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
