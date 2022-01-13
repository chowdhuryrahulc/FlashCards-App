// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flashcards/database/2nd_database_helper.dart';

class audioPlayer extends StatefulWidget {
  String? currentSetUsedForDatabaseSearch;
  audioPlayer({
    Key? key,
    this.currentSetUsedForDatabaseSearch,
  }) : super(key: key);

  @override
  _audioPlayerState createState() => _audioPlayerState();
}

class _audioPlayerState extends State<audioPlayer> {
  final DBManager2 dbManager2 = DBManager2();
  List<nd_title>? list;
  bool togglePlay = false;
  int i = 0;

  updateFavoriteTitle(int favoriteToggle, nd_title ttlmX) {
    if (favoriteToggle == 0) {
      setState(() {
        dbManager2.updateFavoriteTitle(ttlmX, 1);
      });
    } else if (favoriteToggle == 1) {
      setState(() {
        dbManager2.updateFavoriteTitle(ttlmX, 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(6, 25, 6, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder(
                future: widget.currentSetUsedForDatabaseSearch == null
                    ? dbManager2.getnd_TitleList()
                    : dbManager2.getNEWtitleList(
                        widget.currentSetUsedForDatabaseSearch),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    list = snapshot.data;
                    return Column(
                      children: [
                        ListTile(
                          leading: IconButton(
                            color: Colors.red,
                            onPressed: () {
                              updateFavoriteTitle(
                                  list![i].favorite ?? 0, list![i]);
                            },
                            icon: Icon(() {
                              if (list![i].favorite == 1) {
                                return Icons.favorite;
                              } else {
                                return Icons.favorite_border;
                              }
                            }()),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                        ),
                        Text(list![i].term,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 50)),
                        Text(list![i].defination,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 25)),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      if (i != 0) {
                        setState(() {
                          i--;
                        });
                      }
                    },
                    child: Icon(Icons.skip_previous, size: 50)),
                InkWell(
                    onTap: () async {
                      setState(() {
                        togglePlay = !togglePlay;
                      });
                      //
                      for (i; i < list!.length - 1 && togglePlay == true; i++) {
                        await Future.delayed(Duration(seconds: 2));
                        setState(() {});
                      }
                    },
                    child: Icon(
                        togglePlay
                            ? Icons.playlist_play_rounded
                            : Icons.play_circle_outline,
                        size: 50)),
                InkWell(
                    onTap: () {
                      setState(() {
                        if (i < list!.length - 1) {
                          i++;
                        }
                      });
                    },
                    child: Icon(Icons.skip_next, size: 50))
              ],
            )
          ],
        ),
      ),
    );
  }
}
