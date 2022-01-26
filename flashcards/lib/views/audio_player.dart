// ignore_for_file: must_be_immutable

import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:provider/src/provider.dart';

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
  final VocabDatabase dbManager2 = VocabDatabase();
  List<VocabCardModal>? list;

  updateFavoriteTitle(int favoriteToggle, VocabCardModal ttlmX) {
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
    int i = context.watch<iAudioPlayerControl>().i;
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(6, 25, 6, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder(
                future: widget.currentSetUsedForDatabaseSearch == null
                    ? dbManager2.getAllVocabCards()
                    : dbManager2.getVocabCardsusingCurrentSet(
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
                IconButton(
                    iconSize: 50,
                    onPressed: () {
                      context.read<iAudioPlayerControl>().decrement();
                    },
                    icon: Icon(Icons.skip_previous)),
                IconButton(
                    iconSize: 50,
                    onPressed: () {
                      context.read<iAudioPlayerControl>().togglePlayer(list);
                    },
                    icon: Icon(context.watch<iAudioPlayerControl>().togglePlay
                        ? Icons.pause_rounded
                        : Icons.play_circle_outline)),
                IconButton(
                    iconSize: 50,
                    onPressed: () {
                      context.read<iAudioPlayerControl>().increment(list);
                    },
                    icon: Icon(Icons.skip_next))
              ],
            )
          ],
        ),
      ),
    );
  }
}
