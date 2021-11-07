import 'package:flashcards/database/2nd_database_helper.dart';
import 'package:flashcards/database/database_helper.dart';
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
                    // print(titleList![index].nd_id);
                    return CardGrid(list: titleList![index]);
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

class CardGrid extends StatefulWidget {
  CardGrid({Key? key, required this.list}) : super(key: key);
  nd_title list;

  @override
  State<CardGrid> createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  final DBManager2 dbManager2 = DBManager2();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.list.term,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(widget.list.defination, style: TextStyle(fontSize: 15)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      dbManager2.updateFavoriteTitle(widget.list);
                      // updateFavoriteTitle();
                    },
                    // child: if(widget.list.favorite==true){icon: Icon(Icons.favorite_border)} else{icon: Icon(Icons.favorite_border)}
                    // child: widget.list.favorite!
                    //     ? Icon(Icons.favorite_border)
                    //     : Icon(Icons.favorite_border)
                    child: Icon(Icons.favorite_border)), //TODO update favouite
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
                                      termxyz: widget.list.term,
                                      definationxyz: widget.list.defination,
                                      ttl: widget.list,
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
                        dbManager2.deleteTitle(widget.list.nd_id!).then(
                            (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => gridView())));
                        // titleList!.removeAt(index);
                        // Navigator.pop(context);
                        // setState(() {});
                        // });
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
}

// class ListXYZ {
//   String word;
//   String defination;
//   ListXYZ({required this.word, required this.defination});
// }

// var cardGridList = [
//   ListXYZ(word: 'vorrang', defination: 'priority'),
//   ListXYZ(word: 'rachen', defination: 'throat/jaw'),
//   ListXYZ(word: 'untergekommen', defination: 'find a job/accomodaton'),
//   ListXYZ(word: 'borgen', defination: 'borrow'),
//   ListXYZ(word: 'inhaltlich', defination: 'content'),
// ];
