import 'package:flashcards/BasicReview.dart';
import 'package:flashcards/views/audio_player.dart';
import 'package:flashcards/views/match_cards.dart';
import 'package:flashcards/views/select_definition.dart';
import 'package:flashcards/views/writing_review.dart';
import 'package:flashcards/whiteBoardReview.dart';
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
                    'Match between two lists', matchCards()),
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
                    )),
                ListTile(
                    leading: CircleAvatar(),
                    title: Row(
                      children: [Text('Memory Game '), pro()],
                    ),
                    subtitle: Text('Reveal and match cards')),
                ListTile(
                  leading: CircleAvatar(),
                  title: Row(
                    children: [Text('Combined Review (PRO)  '), pro()],
                  ),
                )
              ]),
            ));
      });
}

InkWell practiceListTile(
    BuildContext context, String title, String subtitle, dynamic dynamic) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => dynamic));
    },
    child: ListTile(
        leading: CircleAvatar(),
        title: Row(
          children: [
            Text(title,
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            pro()
          ],
        ),
        subtitle: Text(subtitle)),
  );
}

pro() {
  return Container(
      child: Text('PRO', style: TextStyle(color: Colors.white)),
      color: Colors.blue);
}