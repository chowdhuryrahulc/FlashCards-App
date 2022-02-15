// ignore_for_file: must_be_immutable

import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class audioPlayer extends StatefulWidget {
  List<VocabCardModal> vocabCardModalList;

  audioPlayer({Key? key, required this.vocabCardModalList}) : super(key: key);

  @override
  _audioPlayerState createState() => _audioPlayerState();
}

class _audioPlayerState extends State<audioPlayer> {
  final VocabDatabase dbManager2 = VocabDatabase();

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
    return ChangeNotifierProvider(
      create: (_) => iAudioPlayerControl(),
      child: Builder(builder: (BuildContext context) {
        int i = context.watch<iAudioPlayerControl>().i;
        return WillPopScope(
          onWillPop: () async {
            context.read<iAudioPlayerControl>().makeIZero();
            return true;
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(6, 25, 6, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ListTile(
                        leading: IconButton(
                          color: Colors.red,
                          onPressed: () {
                            updateFavoriteTitle(
                                widget.vocabCardModalList[i].favorite ?? 0,
                                widget.vocabCardModalList[i]);
                          },
                          icon: Icon(() {
                            if (widget.vocabCardModalList[i].favorite == 1) {
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
                      Text(widget.vocabCardModalList[i].term,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 50)),
                      Text(widget.vocabCardModalList[i].defination,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 25)),
                    ],
                  ),
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
                            context
                                .read<iAudioPlayerControl>()
                                .togglePlayer(widget.vocabCardModalList);
                          },
                          icon: Icon(
                              context.watch<iAudioPlayerControl>().togglePlay
                                  ? Icons.pause_rounded
                                  : Icons.play_circle_outline)),
                      IconButton(
                          iconSize: 50,
                          onPressed: () {
                            context
                                .read<iAudioPlayerControl>()
                                .increment(widget.vocabCardModalList);
                          },
                          icon: Icon(Icons.skip_next))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
