import 'package:flashcards/database/2nd_database_helper.dart';
// import 'package:flashcards/database/database_helper.dart';
import 'package:flashcards/views/write.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class gridView extends StatefulWidget {
  const gridView({Key? key}) : super(key: key);

  @override
  State<gridView> createState() => _gridViewState();
}

class _gridViewState extends State<gridView> {
  final DBManager2 dbManager2 = DBManager2();

  List<nd_title>? titleList;

  CardGridX(BuildContext context, nd_title list) {
    final DBManager2 dbManager2 = DBManager2();

    updateFavoriteTitle(int favoriteToggle) {
      if (favoriteToggle == 0) {
        setState(() {
          dbManager2.updateFavoriteTitle(list, 1);
        });
      } else if (favoriteToggle == 1) {
        setState(() {
          dbManager2.updateFavoriteTitle(list, 0);
        });
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              list.term,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(list.defination, style: TextStyle(fontSize: 15)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    updateFavoriteTitle(list.favorite ?? 0);
                  },
                  child: Icon(() {
                    //TODO Color Change
                    if (list.favorite == 1) {
                      // Colors.red;
                      return Icons.favorite;
                    } else {
                      return Icons.favorite_border;
                    }
                  }()),
                ),
                PopupMenuButton(itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                        child: InkWell(
                      onTap: () {
                        bool? edi = true;
                        // print(list.term);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => write(
                                      editxyz: edi,
                                      termxyz: list.term,
                                      definationxyz: list.defination,
                                      ttl: list,
                                    )));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Icon(Icons.edit), Text(' Edit')],
                      ),
                    )),
                    PopupMenuItem(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Icon(Icons.show_chart), Text(' Progress')],
                    )),
                    PopupMenuItem(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.add_circle_outline),
                        Text(' Add to ignored')
                      ],
                    )),
                    PopupMenuItem(
                        child: InkWell(
                      onTap: () {
                        // delete
                        // setState(() {
                        dbManager2
                            .deleteTitle(list.nd_id!)
                            .then((value) => setState(() {
                                  Navigator.pop(context);
                                }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          Text(' Remove')
                        ],
                      ),
                    ))
                  ];
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt_outlined)),
        PopupMenuButton(itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(child: Text("Manage cards   ")),
            PopupMenuItem(child: Text('Manage tags')),
            PopupMenuItem(child: Text("Sync")),
          ];
        })
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: dbManager2.getnd_TitleList(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                titleList = snapshot.data;
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: titleList!.length, //!
                  itemBuilder: (context, index) {
                    return CardGridX(context, titleList![index]);
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  shrinkWrap: true,
                );
              }
              return CircularProgressIndicator();
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("CREATE SET"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => write()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
