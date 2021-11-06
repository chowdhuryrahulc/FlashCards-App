import 'package:flashcards/writeexample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class Grid_View extends StatelessWidget {
//   const Grid_View({Key? key}) : super(key: key);

// }
class gridView extends StatelessWidget {
  const gridView({Key? key}) : super(key: key);

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
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: cardGridList.length,
          itemBuilder: (context, index) => CardGrid(list: cardGridList[index]),
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          shrinkWrap: true,
        ),
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
  ListXYZ list;

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
              list.word,
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
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        Text(' Remove')
                      ],
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

class ListXYZ {
  String word;
  String defination;
  ListXYZ({required this.word, required this.defination});
}

var cardGridList = [
  ListXYZ(word: 'vorrang', defination: 'priority'),
  ListXYZ(word: 'rachen', defination: 'throat/jaw'),
  ListXYZ(word: 'untergekommen', defination: 'find a job/accomodaton'),
  ListXYZ(word: 'borgen', defination: 'borrow'),
  ListXYZ(word: 'inhaltlich', defination: 'content'),
];
