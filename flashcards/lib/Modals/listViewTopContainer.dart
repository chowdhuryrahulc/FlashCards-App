import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/Widgets/Practice.dart';
import 'package:flutter/material.dart';
import '../database/VocabDatabase.dart';
import '../views/BasicReview.dart';

Container listViewTopContainer(BuildContext context) {
  final VocabDatabase vocabDatabase = VocabDatabase();
  List<VocabCardModal>? vocabCardModalList;

  return Container(
      height: 140,
      padding: EdgeInsets.symmetric(horizontal: 18),
      color: Theme.of(context).colorScheme.secondary,
      child: FutureBuilder(
          future: vocabDatabase.getAllVocabCards(),
          builder: (context, AsyncSnapshot snapshot) {
            vocabCardModalList = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.grey),
                  ),
                  child: ListTile(
                    leading: Text(
                      'All Sets',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 130,
                        height: 35,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BasicReview()));
                          },
                          child: Text("REVIEW ALL",
                              style: TextStyle(color: Colors.blue)),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40.0)))),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 130,
                      height: 35,
                      child: OutlinedButton(
                        onPressed: () {
                          Practice(context, vocabCardModalList);
                        },
                        child: Text("PRACTICE ALL",
                            style: TextStyle(color: Colors.blue)),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(40.0)))),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }));
}
