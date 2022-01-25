import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flashcards/main.dart';
import 'package:flashcards/views/list_view.dart';
import 'package:flashcards/views/write.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/src/provider.dart';

class gridView extends StatefulWidget {
  String? currentSetUsedForDatabaseSearch;
  gridView({Key? key, this.currentSetUsedForDatabaseSearch})
      : super(key: key); //! ttl entry

  @override
  State<gridView> createState() => _gridViewState();
}

class _gridViewState extends State<gridView> {
  final VocabDatabase dbManager2 = VocabDatabase();

  List<VocabCardModal>? titleList;

  CardGridX(BuildContext context, VocabCardModal list) {
    final VocabDatabase dbManager2 = VocabDatabase();

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

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.only(top: 8.0, left: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            list.term,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(height: 10),
          Text(list.defination,
              style: TextStyle(
                  fontSize: 15, color: Theme.of(context).colorScheme.primary)),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                color: Colors.red,
                onPressed: () {
                  updateFavoriteTitle(list.favorite ?? 0);
                },
                icon: Icon(() {
                  if (list.favorite == 1) {
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => write(
                                          editxyz: edi,
                                          termxyz: list.term,
                                          definationxyz: list.defination,
                                          vocabCard: list,
                                          currentSet: widget
                                              .currentSetUsedForDatabaseSearch,
                                        ))).then((value) {
                              setState(() {
                                Navigator.pop(context);
                              });
                            });
                          },
                          child: popUpTitle(Icons.edit, 'Edit'))),
                  PopupMenuItem(
                      child: popUpTitle(Icons.show_chart, 'Progress')),
                  PopupMenuItem(
                      child: popUpTitle(
                          Icons.add_circle_outline, 'Add to ignored')),
                  PopupMenuItem(
                      child: InkWell(
                    onTap: () {
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
    );
  }

  @override
  Widget build(BuildContext context) {
    bool visibleTernaryFAB =
        context.watch<gridViewVisibleControl>().visibleTernaryFAB;
    if (widget.currentSetUsedForDatabaseSearch == null) {
      context.read<gridViewVisibleControl>().updateVisibleTernaryFAB(false);
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(105),
        child: Column(
          children: [
            AppBar(elevation: 0, actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.filter_alt_outlined)),
              PopupMenuButton(itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(child: Text("Manage cards   ")),
                  PopupMenuItem(child: Text('Manage tags')),
                  PopupMenuItem(child: Text("Sync")),
                ];
              }),
            ]),
            Memorized(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: FutureBuilder(
            future: widget.currentSetUsedForDatabaseSearch == null
                ? dbManager2.getAllVocabCards()
                : dbManager2.getVocabCardsusingCurrentSet(
                    widget.currentSetUsedForDatabaseSearch),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                titleList = snapshot.data;
                return Scrollbar(
                  thickness: 10,
                  child: NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      if (notification.direction == ScrollDirection.forward ||
                          notification.direction == ScrollDirection.reverse) {
                        context
                            .read<gridViewVisibleControl>()
                            .updateVisibleTernaryFAB(false);
                      } else {
                        context
                            .read<gridViewVisibleControl>()
                            .updateVisibleTernaryFAB(true);
                      }
                      return true;
                    },
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: titleList!.length,
                      itemBuilder: (context, index) {
                        return CardGridX(context, titleList![index]);
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      shrinkWrap: true,
                    ),
                  ),
                );
              }
              return Container();
            }),
      ),
      floatingActionButton: visibleTernaryFAB
          ? FloatingActionButton.extended(
              label: Text("ADD CARDS"),
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => write(
                              currentSet:
                                  widget.currentSetUsedForDatabaseSearch,
                            ))).then((value) {
                  setState(() {});
                });
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Memorized() {
    // Future<int> j = dbManager2.getCount();
    // print(j);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              horizontalViewContainer('All', 1000),
              horizontalViewContainer('NOT MEMORIZED', 1000),
              horizontalViewContainer('MEMORIZED', 1000),
            ],
          ),
        ),
      ),
    );
  }

  horizontalViewContainer(String name, int number) {
    bool horizontalButtonTheme = true;
    return Container(
      decoration: BoxDecoration(
          color: horizontalButtonTheme ? Colors.transparent : Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.blue)),
      child: InkWell(
        onTap: () {
          horizontalButtonTheme = !horizontalButtonTheme;
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            '${name}:- ${number}',
            //${titleList!.length}',
            style: TextStyle(
                fontSize: 20,
                color: horizontalButtonTheme ? Colors.blue : Colors.white),
          ),
        ),
      ),
    );
  }
}
