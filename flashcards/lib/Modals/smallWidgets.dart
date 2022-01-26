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

InkWell practiceListTile(
    BuildContext context, String title, String subtitle, dynamic dynamic,
    {bool vissible = false}) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => dynamic));
    },
    child: ListTile(
        leading: CircleAvatar(),
        title: Row(
          children: [
            Text(title,
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            Visibility(visible: vissible, child: pro())
          ],
        ),
        subtitle: Text(subtitle,
            style: TextStyle(color: Theme.of(context).colorScheme.primary))),
  );
}

pro() {
  return Container(
      child: Text('PRO', style: TextStyle(color: Colors.white)),
      color: Colors.blue);
}
