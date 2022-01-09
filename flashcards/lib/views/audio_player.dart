// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:flashcards/database/2nd_database_helper.dart';

class audioPlayer extends StatefulWidget {
  String? currentSetUsedForDatabaseSearch;
  audioPlayer({
    Key? key,
    this.currentSetUsedForDatabaseSearch,
  }) : super(key: key);

  @override
  _audioPlayerState createState() => _audioPlayerState();
}

class _audioPlayerState extends State<audioPlayer> {
  final DBManager2 dbManager2 = DBManager2();
  List<nd_title>? list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(6, 25, 6, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder(
                future: widget.currentSetUsedForDatabaseSearch == null
                    ? dbManager2.getnd_TitleList()
                    : dbManager2.getNEWtitleList(
                        widget.currentSetUsedForDatabaseSearch),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    list = snapshot.data;
                    // for (var i = 0; i < list!.length; i++) {
                    //   nd_title ttlm = list![i];
                    //   // Text(ttlm.term);
                    // }
                    return Column(
                      children: [
                        ListTile(
                          leading:
                              Icon(Icons.favorite_border, color: Colors.red),
                        ),
                        SizedBox(
                          height: 300,
                        ),
                        Text('term',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {},
                    child: Icon(Icons.skip_previous,
                        size: 50, color: Colors.white)),
                InkWell(
                    onTap: () {},
                    child: Icon(Icons.play_circle_outline,
                        size: 50, color: Colors.white)),
                InkWell(
                    onTap: () {},
                    child: Icon(Icons.skip_next, size: 50, color: Colors.white))
              ],
            )
          ],
        ),
      ),
    );
  }
}
