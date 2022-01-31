import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BasicReview extends StatefulWidget {
  String? currentSetUsedForDatabaseSearch;
  BasicReview({Key? key, this.currentSetUsedForDatabaseSearch})
      : super(key: key);

  @override
  _BasicReviewState createState() => _BasicReviewState();
}

class _BasicReviewState extends State<BasicReview> {
  final VocabDatabase vocabDatabase = VocabDatabase();
  List<VocabCardModal>? vocabCardModalList;
  PageController insidePageController = PageController();
  PageController outsidePageController = PageController();

  updateFavoriteTitle(int favoriteToggle, VocabCardModal ttlmX) {
    if (favoriteToggle == 0) {
      setState(() {
        vocabDatabase.updateFavoriteTitle(ttlmX, 1);
      });
    } else if (favoriteToggle == 1) {
      setState(() {
        vocabDatabase.updateFavoriteTitle(ttlmX, 0);
      });
    }
  }

  // final Stream<QuerySnapshot> users =
  //     FirebaseFirestore.instance.collection("users").snapshots();
  final TTS = FlutterTts();

  Future S(X) async {
    await TTS.speak(X);
  }

  // int N = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.clear_sharp)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.flip_to_front)),
          ]),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
            child: FutureBuilder(
          future: widget.currentSetUsedForDatabaseSearch == null
              ? vocabDatabase.getAllVocabCards()
              : vocabDatabase.getVocabCardsusingCurrentSet(
                  widget.currentSetUsedForDatabaseSearch),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              vocabCardModalList = snapshot.data;
              // vocabCardModalList!.shuffle();
              return PageView.builder(
                  controller: outsidePageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: vocabCardModalList!.length,
                  itemBuilder: (context, index) {
                    VocabCardModal singleVocabCard = vocabCardModalList![index];
                    return Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: insidePageController,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            onPageChanged: (number) {
                              // print('Page number is ' + number.toString());
                            },
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: singleVocabCard.picture == null
                                      ? null
                                      : DecorationImage(
                                          image: MemoryImage(
                                              singleVocabCard.picture!),
                                          fit: BoxFit.fill),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                ),
                                margin: EdgeInsets.all(8),
                                child: InkWell(
                                  onTap: () {
                                    // pageController.jumpToPage(1);
                                    insidePageController.animateToPage(1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                          top: 0,
                                          left: 0,
                                          child: IconButton(
                                            color: Colors.red,
                                            onPressed: () {
                                              updateFavoriteTitle(
                                                  singleVocabCard.favorite ?? 0,
                                                  singleVocabCard);
                                            },
                                            icon: Icon(() {
                                              if (singleVocabCard.favorite ==
                                                  1) {
                                                return Icons.favorite;
                                              } else {
                                                return Icons.favorite_border;
                                              }
                                            }()),
                                          )),
                                      Text(
                                        '${singleVocabCard.term}',
                                        style: TextStyle(fontSize: 50),
                                        textAlign: TextAlign.center,
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          left: 0,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.edit))),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.play_circle_outline),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: FloatingActionButton(
                                            heroTag: singleVocabCard.term,
                                            backgroundColor: Colors.red,
                                            child: Icon(Icons.rotate_right),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(8),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryVariant,
                                child: InkWell(
                                  onTap: () {
                                    // pageController.jumpToPage(0);
                                    insidePageController.animateToPage(0,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        "${singleVocabCard.defination}",
                                        style: TextStyle(fontSize: 50),
                                        textAlign: TextAlign.center,
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.play_circle_outline),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: FloatingActionButton(
                                            heroTag: singleVocabCard.defination,
                                            backgroundColor: Colors.red,
                                            child: Icon(Icons.rotate_right),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 56,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              basicReviewBottomButtons(
                                  buttonName: 'Hard',
                                  buttonColor: Colors.red,
                                  outsidePageController: outsidePageController,
                                  vocabCardModalList: vocabCardModalList),
                              basicReviewBottomButtons(
                                  buttonName: 'Normal',
                                  buttonColor: Colors.blue,
                                  outsidePageController: outsidePageController,
                                  vocabCardModalList: vocabCardModalList),
                              basicReviewBottomButtons(
                                  buttonName: 'Easy',
                                  buttonColor: Colors.green,
                                  outsidePageController: outsidePageController,
                                  vocabCardModalList: vocabCardModalList)
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              return Container();
            }
          },
        )),
      ]),
    );
  }
}

class basicReviewBottomButtons extends StatelessWidget {
  const basicReviewBottomButtons({
    Key? key,
    required this.buttonName,
    required this.buttonColor,
    required this.outsidePageController,
    required this.vocabCardModalList,
  }) : super(key: key);
  final Color buttonColor;
  final String buttonName;
  final PageController outsidePageController;
  final List<VocabCardModal>? vocabCardModalList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width / 3,
      child: MaterialButton(
        onPressed: () {
          nextPage(outsidePageController, vocabCardModalList);
        },
        child: Text(buttonName),
        color: buttonColor,
      ),
    );
  }
}

nextPage(PageController pageController2, List<VocabCardModal>? list) {
  if (pageController2.page!.toInt() < list!.length - 1) {
    pageController2.animateToPage(pageController2.page!.toInt() + 1,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}



          // SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     child: StreamBuilder<QuerySnapshot>(
          //         stream: users,
          //         builder: (
          //           BuildContext context,
          //           AsyncSnapshot<QuerySnapshot> snapshot,
          //         ) {
          //           if (snapshot.hasError) {
          //             return Text("Something went wrong");
          //           }
          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return Text("Loading");
          //           }
          //           final data = snapshot.requireData;
          //           {
          //             return Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: FlipCard(
          //                 front: GestureDetector(
          //                   onHorizontalDragStart:
          //                       (DragStartDetails dragStartDetails) {
          //                     setState(() {
          //                       N = N - 1;
          //                     });
          //                   },
          //                   child: Card(
          //                     color: Colors.blue,
          //                     child: Stack(
          //                       alignment: Alignment.center,
          //                       children: [
          //                         Positioned(
          //                             top: 0,
          //                             left: 0,
          //                             child: IconButton(
          //                                 onPressed: () {},
          //                                 icon: Icon(Icons.favorite))),
          //                         Text(
          //                           "${data.docs[N]['name']}",
          //                           textAlign: TextAlign.center,
          //                         ),
          //                         Positioned(
          //                             bottom: 0,
          //                             left: 0,
          //                             child: IconButton(
          //                                 onPressed: () {},
          //                                 icon: Icon(Icons.edit))),
          //                         Positioned(
          //                           right: 0,
          //                           bottom: 0,
          //                           child: IconButton(
          //                             onPressed: () {
          //                               // S("${data.docs[N]['name']}");
          //                             },
          //                             icon: Icon(Icons.play_circle_outline),
          //                           ),
          //                         ),
          //                         Positioned(
          //                           bottom: 8,
          //                           child: Align(
          //                             alignment: Alignment.bottomCenter,
          //                             child: FloatingActionButton(
          //                               backgroundColor: Colors.red,
          //                               child: Icon(Icons.rotate_right),
          //                               onPressed: () {},
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 back: GestureDetector(
          //                   onHorizontalDragStart:
          //                       (DragStartDetails dragStartDetails) {
          //                     setState(() {
          //                       N = N - 1;
          //                     });
          //                   },
          //                   child: Card(
          //                     color: Colors.green,
          //                     child: Stack(
          //                       alignment: Alignment.center,
          //                       children: [
          //                         Text(
          //                           "${data.docs[N]['Notes']}",
          //                           textAlign: TextAlign.center,
          //                         ),
          //                         Positioned(
          //                           right: 0,
          //                           bottom: 0,
          //                           child: IconButton(
          //                             onPressed: () {
          //                               // S("${data.docs[N]['Notes']}");
          //                             },
          //                             icon: Icon(Icons.play_circle_outline),
          //                           ),
          //                         ),
          //                         Positioned(
          //                           bottom: 8,
          //                           child: Align(
          //                             alignment: Alignment.bottomCenter,
          //                             child: FloatingActionButton(
          //                               heroTag: 'true',
          //                               backgroundColor: Colors.red,
          //                               child: Icon(Icons.rotate_right),
          //                               onPressed: () {},
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             );
          //           }
          //         }),
          //   ),
          // ),