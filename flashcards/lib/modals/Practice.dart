import 'package:flashcards/BasicReview.dart';
import 'package:flashcards/views/audio_player.dart';
import 'package:flashcards/views/select_definition.dart';
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BasicReview(
                                currentSetUsedForDatabaseSearch: cardName)));
                  },
                  child: ListTile(
                      leading: CircleAvatar(),
                      title: Text('Basic Review'),
                      subtitle: Text('Basic flashcards review')),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => select_definition(
                                  currentSetUsedForDatabaseSearch: cardName,
                                )));
                  },
                  child: ListTile(
                      leading: CircleAvatar(),
                      title: Text('Select Definition'),
                      subtitle: Text('Select the correct definition')),
                ),
                ListTile(
                    leading: CircleAvatar(),
                    title: Text('Match Cards'),
                    subtitle: Text('Match between two lists')),
                ListTile(
                    leading: CircleAvatar(),
                    title: Text('Writing Review'),
                    subtitle: Text('Review by writing')),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => audioPlayer(
                                  currentSetUsedForDatabaseSearch: cardName,
                                )));
                  },
                  child: ListTile(
                      leading: CircleAvatar(),
                      title: Text('Audio Player'),
                      subtitle: Text('Review by listening to your cards')),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WhiteBoardReview(
                                  currentSetUsedForDatabaseSearch: cardName,
                                )));
                  },
                  child: ListTile(
                      leading: CircleAvatar(),
                      title: Row(
                        children: [Text('Whiteboard review  '), pro()],
                      ),
                      subtitle: Text('Practice by drawing the answer')),
                ),
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

pro() {
  return Container(
      child: Text('PRO', style: TextStyle(color: Colors.white)),
      color: Colors.blue);
}
