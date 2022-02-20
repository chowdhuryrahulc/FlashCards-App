import 'package:flashcards/views/BasicReview.dart';
import 'package:flashcards/views/audio_player.dart';
import 'package:flashcards/views/select_definition.dart';
import 'package:flashcards/views/whiteBoardReview.dart';
import 'package:flutter/material.dart';
import '../Modals/practiceListTile.dart';
import '../Modals/vocabCardModal.dart';

Future<dynamic> Practice(
    BuildContext context, List<VocabCardModal> vocabCardModalList,
    {cardName}) {
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
                  BasicReview(
                    currentSetUsedForDatabaseSearch: cardName,
                    // vocabCardModalList: vocabCardModalList
                  ),
                  0,
                  vocabCardModalList.length,
                ),
                practiceListTile(
                  context,
                  'Select Definition',
                  'Select the correct definition',
                  select_definition(vocabCardModalList: vocabCardModalList),
                  5,
                  vocabCardModalList.length,
                ),
                // practiceListTile(context, 'Match Cards',
                //     'Match between two lists', matchCards(), 10,
                //     cardName: cardName),
                // practiceListTile(context, 'Writing Review', 'Review by writing',
                //     writingReview(), 0,
                //     cardName: cardName),
                practiceListTile(
                  context,
                  'Audio Player',
                  'Review by listening to your cards',
                  audioPlayer(
                    currentSetUsedForDatabaseSearch: cardName,
                    // vocabCardModalList: vocabCardModalList
                  ),
                  0,
                  vocabCardModalList.length,
                ),
                practiceListTile(
                    context,
                    'Whiteboard review  ',
                    'Practice by drawing the answer',
                    WhiteBoardReview(vocabCardModalList: vocabCardModalList),
                    0,
                    vocabCardModalList.length,
                    vissible: true),
                // practiceListTile(context, 'Memory Game ',
                //     'Reveal and match cards', MemoryGame(), 0,
                //     cardName: cardName, vissible: true),
                // practiceListTile(
                //     context, 'Combined Review (PRO)  ', '', CombinedReview(), 0,
                //     cardName: cardName, vissible: true)
              ]),
            ));
      });
}
