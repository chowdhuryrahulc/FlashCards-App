import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Modals/smallWidgets.dart';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flashcards/views/list_view.dart';
import 'package:flashcards/views/write.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/src/provider.dart';

class gridView extends StatefulWidget {
  String? currentSetUsedForDatabaseSearch;
  List<VocabCardModal> vocabCardModalList;

  gridView(
      {Key? key,
      this.currentSetUsedForDatabaseSearch,
      required this.vocabCardModalList})
      : super(key: key); //! ttl entry

  @override
  State<gridView> createState() => _gridViewState();
}

class _gridViewState extends State<gridView> {
  final VocabDatabase dbManager2 = VocabDatabase();

  bool visibleListExample = false;

  updateFavoriteTitle(
    int favoriteToggle,
    VocabCardModal singleVocabCard,
  ) {
    if (favoriteToggle == 0) {
      setState(() {
        dbManager2.updateFavoriteTitle(singleVocabCard, 1);
      });
    } else if (favoriteToggle == 1) {
      setState(() {
        dbManager2.updateFavoriteTitle(singleVocabCard, 0);
      });
    }
  }

  // CardGridX(context, VocabCardModal singleVocabCard) {
  //   final VocabDatabase dbManager2 = VocabDatabase();

  //   return }

  @override
  Widget build(BuildContext context) {
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
          child: widget.vocabCardModalList.length != 0
              ? Scrollbar(
                  thickness: 10,
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: widget.vocabCardModalList.length,
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      VocabCardModal singleVocabCard =
                          widget.vocabCardModalList[index];
                      return Container(
                        color: Theme.of(context).colorScheme.secondary,
                        margin: EdgeInsets.all(4.0),
                        padding: EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              singleVocabCard.term,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            SizedBox(height: 10),
                            Text(singleVocabCard.defination,
                                style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            SizedBox(height: 15),
                            Text(singleVocabCard.example!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            singleVocabCard.picture != null
                                ? Center(
                                    child: Container(
                                        height: 100,
                                        color: Colors.white,
                                        child: Image.memory(
                                            singleVocabCard.picture!)))
                                : SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    updateFavoriteTitle(
                                        singleVocabCard.favorite ?? 0,
                                        singleVocabCard);
                                    // context.read<gridViewVisibleControl>().updateFavoriteTitle(
                                    //     singleVocabCard.favorite ?? 0, singleVocabCard);
                                  },
                                  icon: Icon(() {
                                    if (singleVocabCard.favorite == 1) {
                                      return Icons.favorite;
                                    } else {
                                      return Icons.favorite_border;
                                    }
                                  }()),
                                  // context.watch<gridViewVisibleControl>().favoriteToggle == 1
                                  //     ? Icon(Icons.favorite)
                                  //     : Icon(Icons.favorite_border),
                                ),
                                PopupMenuButton(
                                    itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                        child: InkWell(
                                            onTap: () {
                                              bool? edi = true;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          write(
                                                            editxyz: edi,
                                                            termxyz:
                                                                singleVocabCard
                                                                    .term,
                                                            definationxyz:
                                                                singleVocabCard
                                                                    .defination,
                                                            examplexyz:
                                                                singleVocabCard
                                                                    .example,
                                                            vocabCard:
                                                                singleVocabCard,
                                                            currentSet: widget
                                                                .currentSetUsedForDatabaseSearch,
                                                          ))).then((value) {
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              });
                                            },
                                            child: popUpTitle(
                                                Icons.edit, 'Edit'))),
                                    PopupMenuItem(
                                        child: popUpTitle(
                                            Icons.show_chart, 'Progress')),
                                    PopupMenuItem(
                                        child: popUpTitle(
                                            Icons.add_circle_outline,
                                            'Add to ignored')),
                                    PopupMenuItem(
                                        child: InkWell(
                                      onTap: () {
                                        dbManager2
                                            .deleteTitle(singleVocabCard.nd_id!)
                                            .then((value) => setState(() {
                                                  Navigator.pop(context);
                                                }));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                    },
                  ),
                )
              : gridViewEmptyContainer()),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("ADD CARDS"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => write(
                        currentSet: widget.currentSetUsedForDatabaseSearch,
                      ))).then((value) {
            setState(() {});
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Memorized() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              horizontalViewContainer('All', widget.vocabCardModalList.length),
              horizontalViewContainer('MEMORIZED', 1000),
              horizontalViewContainer('NOT MEMORIZED', 1000),
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
            style: TextStyle(
                fontSize: 20,
                color: horizontalButtonTheme ? Colors.blue : Colors.white),
          ),
        ),
      ),
    );
  }
}
