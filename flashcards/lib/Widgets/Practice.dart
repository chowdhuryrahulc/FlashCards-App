import 'package:flashcards/Modals/smallWidgets.dart';
import 'package:flashcards/views/BasicReview.dart';
import 'package:flashcards/views/audio_player.dart';
import 'package:flashcards/views/combined_review.dart';
import 'package:flashcards/views/match_cards.dart';
import 'package:flashcards/views/memory_game.dart';
import 'package:flashcards/views/select_definition.dart';
import 'package:flashcards/views/writing_review.dart';
import 'package:flashcards/views/whiteBoardReview.dart';
import 'package:flutter/material.dart';

Future<dynamic> Practice(BuildContext context, {cardName}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.check))
                ],
              ),
              body: ListView(children: [
                practiceListTile(
                    context,
                    'Basic Review',
                    'Basic flashcards review',
                    BasicReview(currentSetUsedForDatabaseSearch: cardName)),
                practiceListTile(
                    context,
                    'Select Definition',
                    'Select the correct definition',
                    select_definition(
                      currentSetUsedForDatabaseSearch: cardName,
                    )),
                practiceListTile(context, 'Match Cards',
                    'Match between two lists', match_cards()),
                practiceListTile(context, 'Writing Review', 'Review by writing',
                    writingReview()),
                practiceListTile(
                    context,
                    'Audio Player',
                    'Review by listening to your cards',
                    audioPlayer(
                      currentSetUsedForDatabaseSearch: cardName,
                    )),
                practiceListTile(
                    context,
                    'Whiteboard review  ',
                    'Practice by drawing the answer',
                    WhiteBoardReview(
                      currentSetUsedForDatabaseSearch: cardName,
                    ),
                    vissible: true),
                practiceListTile(context, 'Memory Game ',
                    'Reveal and match cards', MemoryGame(),
                    vissible: true),
                practiceListTile(
                    context, 'Combined Review (PRO)  ', '', CombinedReview(),
                    vissible: true)
              ]),
            ));
      });
}