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

class CardGrid extends StatelessWidget {
  CardGrid({Key? key, required this.list}) : super(key: key);
  nd_title list;

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
              list.term,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(list.defination, style: TextStyle(fontSize: 15)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.favorite_border),
                PopupMenuButton(itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Icon(Icons.edit), Text(' Edit')],
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

                        // floatingdialog(context,
                        //         title: ttl.name,
                        //         description: ttl.description,
                        //         edit: edi,
                        //         ttl: ttl)
                        //     .then((value) {
                        //   setState(() {
                        //     Navigator.pop(context);
                        //   });
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
