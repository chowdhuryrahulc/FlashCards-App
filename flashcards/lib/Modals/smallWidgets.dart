import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flashcards/views/whiteBoardReview.dart';
import 'package:flutter/material.dart';

InkWell addDrawingColorControls(
    CanvasController canvasController, Color color, BuildContext context) {
  return InkWell(
    onTap: () {
      canvasController.isEraseMode = false;
      canvasController.brushColor = color;
    },
    child: Container(
      height: 56,
      color: color,
      width: (MediaQuery.of(context).size.width - 40) / 4,
    ),
  );
}

Container createYourFirstSetListView(context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    child: Center(
      child: Text(
        'Create your first set',
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}

Container gridViewEmptyContainer() {
  return Container(
    child: Center(
      child: Text(
        'Add cards to start studying.',
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}

practiceListTile(BuildContext context, String title, String subtitle,
    dynamic dynamic, int minimumRequiredCards,
    {String? cardName, bool vissible = false}) {
  final VocabDatabase vocabDatabase = VocabDatabase();
  List<VocabCardModal>? vocabCardModalList;

  return FutureBuilder(
      future: cardName == null
          ? vocabDatabase.getAllVocabCards()
          : vocabDatabase.getVocabCardsusingCurrentSet(cardName),
      builder: (context, AsyncSnapshot snapshot) {
        return ListTile(
            onTap: () {
              Navigator.pop(context);
              if (snapshot.hasData) {
                vocabCardModalList = snapshot.data;
                if (vocabCardModalList!.length > minimumRequiredCards) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => dynamic));
                } else {
                  safetyAlertDialog(context, minimumRequiredCards);
                }
              } else {
                safetyAlertDialog(context, minimumRequiredCards);
              }
            },
            leading: CircleAvatar(),
            title: Row(
              children: [
                Text(title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                Visibility(visible: vissible, child: pro())
              ],
            ),
            subtitle: Text(subtitle,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.primary)));
      });
}

Future<dynamic> safetyAlertDialog(
    BuildContext context, int minimumRequiredCards) {
  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text('Begin Review'),
          content: Text(
              'Please add at least ${minimumRequiredCards + 1} cards to start practicing.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CLOSE'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('ADD CARDS'),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            )
          ],
          backgroundColor: Colors.white,
        );
      }));
}

pro() {
  return Container(
      child: Text('PRO', style: TextStyle(color: Colors.white)),
      color: Colors.blue);
}
