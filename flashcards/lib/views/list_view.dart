import 'dart:ffi';
import 'dart:typed_data';

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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Modals/listViewTopContainer.dart';
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

final skey = GlobalKey<ScaffoldState>();

class _list_viewState extends State<list_view> {
  String email = '';
  String displayName = '';
  // Uint8List? photoURL;
  // Uint8List photoURL = Uint8List.fromList([

  @override
  void initState() {
    getUserDetailsinSharedPreferences();
    super.initState();
  }

  getUserDetailsinSharedPreferences() async {
    SharedPreferences loginDetails = await SharedPreferences.getInstance();
    email = loginDetails.getString('email')!;
    displayName = loginDetails.getString('displayName')!;
    // String photo = loginDetails.getString('photoURL')!;
    // photoURL = Uint8List.fromList(photo.codeUnits);
    // print('UINT8LIST CREDENTIALS IS ${photoURL}');
    setState(() {}); // Probably do not need setstate?
  }

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

  Widget listViewContainer(
      Headlines ttl,
      List<VocabCardModal>? vocabCardModalList,
      Color textThemeControl,
      int index,
      {bool noCards = false}) {
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
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.blue,
              Theme.of(context).colorScheme.secondary
            ]),
            borderRadius: BorderRadius.all(const Radius.circular(6.0))),
        child: InkWell(
          splashColor: Colors.grey[600],
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => gridView(
                            currentSetUsedForDatabaseSearch: ttl.name,
                            vocabCardModalList: vocabCardModalList!)))
                .then((value) {
              setState(() {});
            });
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
                      style: TextStyle(fontSize: 35, color: textThemeControl),
                    ),
                    Text(
                      "${vocabCardModalList!.length} cards total",
                      style: TextStyle(fontSize: 12, color: textThemeControl),
                    ),
                  ],
                ),
              )),
              Positioned(
                  top: 0,
                  right: 0,
                  child: PopupMenuButton(itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            bool? edi = true;
                            createSet(context,
                                title: ttl.name,
                                description: ttl.description,
                                edit: edi,
                                ttl: ttl);
                          },
                          child: popUpTitle(Icons.edit, "Edit"),
                        ),
                      ),
                      PopupMenuItem(
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return gridView(
                                      currentSetUsedForDatabaseSearch: ttl.name,
                                      vocabCardModalList: vocabCardModalList);
                                }));
                              },
                              child: popUpTitle(Icons.add, "Add cards"))),
                      PopupMenuItem(
                          child: InkWell(
                              onTap: () {
                                share(context);
                                Navigator.pop(context);
                              },
                              child: popUpTitle(Icons.share, "Share"))),
                      PopupMenuItem(
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                updateArchiveTitle(ttl);
                              },
                              child: popUpTitle(Icons.archive, "Archive"))),
                      PopupMenuItem(
                          child:
                              popUpTitle(Icons.import_export, "Export Cards")),
                      PopupMenuItem(
                          child: popUpTitle(Icons.style, "Merge sets")),
                      PopupMenuItem(
                          child: popUpTitle(Icons.move_to_inbox, "Move Cards")),
                      PopupMenuItem(
                          child: InkWell(
                        onTap: () async {
                          await dbManager.deleteTitle(ttl.id!).then((value) {
                            titleList!.removeAt(index);
                            setState(() {});
                            Navigator.pop(context);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                          child: noCards
                              ? addCardsButton(ttl)
                              : OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BasicReview(
                                                  vocabCardModalList:
                                                      vocabCardModalList,
                                                )));
                                  },
                                  child: Text("REVIEW",
                                      style: TextStyle(color: Colors.blue)),
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
                            Practice(context, vocabCardModalList,
                                cardName: ttl.name);
                          },
                          child: Text("PRACTICE",
                              style: TextStyle(color: Colors.blue)),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40.0)))),
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
  }

  @override
  Widget build(BuildContext context) {
    final textThemeControl = Theme.of(context).colorScheme.primary;
    Headlines? head = context.watch<createSetFutureHeadlineControl>().headline;
    return Scaffold(
      key: skey,
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
      drawer: drawer(
        email: email,
        displayName: displayName,
        // photoURL: photoURL,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: FutureBuilder(
            future: dbManager.getTitleList(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                titleList = snapshot.data;
                if (titleList!.length != 0) {
                  return Column(children: [
                    listViewTopContainer(context),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Scrollbar(
                        child: ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: titleList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Headlines ttl = titleList![index];
                              return FutureBuilder(
                                  future: vocabDatabase
                                      .getVocabCardsusingCurrentSet(ttl.name),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      vocabCardModalList = snapshot.data;
                                      if (vocabCardModalList!.length != 0) {
                                        return listViewContainer(
                                            ttl,
                                            vocabCardModalList,
                                            textThemeControl,
                                            index);
                                      } else
                                        return listViewContainer(
                                            ttl,
                                            vocabCardModalList,
                                            textThemeControl,
                                            index,
                                            noCards: true);
                                    } else
                                      return Container(
                                        height: 150,
                                      );
                                  });
                            }),
                      ),
                    )
                  ]);
                } else {
                  return createYourFirstSetListView(context);
                }
              } else {
                return createYourFirstSetListView(context);
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
                builder: (context) => gridView(
                    currentSetUsedForDatabaseSearch: ttl.name,
                    vocabCardModalList: vocabCardModalList!))).then((value) {
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
