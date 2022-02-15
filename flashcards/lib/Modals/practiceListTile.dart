import 'package:flashcards/Modals/smallWidgets.dart';
import 'package:flutter/material.dart';

practiceListTile(BuildContext context, String title, String subtitle,
    dynamic dynamic, int minimumRequiredCards, int lengthOfCards,
    {bool vissible = false}) {
  return ListTile(
      onTap: () {
        Navigator.pop(context);
        if (lengthOfCards > minimumRequiredCards) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => dynamic));
        } else {
          safetyAlertDialog(context, minimumRequiredCards);
        }
      },
      leading: CircleAvatar(),
      title: Row(
        children: [
          Text(title,
              style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          Visibility(visible: vissible, child: pro())
        ],
      ),
      subtitle: Text(subtitle,
          style: TextStyle(color: Theme.of(context).colorScheme.primary)));
}
