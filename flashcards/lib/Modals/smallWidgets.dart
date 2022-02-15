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
