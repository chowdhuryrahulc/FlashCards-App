import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/database/2nd_database_helper.dart';
import 'package:flashcards/views/Firstpage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// import 'package:flutter_tts/flutter_tts.dart';

class BasicReview extends StatefulWidget {
  const BasicReview({Key? key}) : super(key: key);

  @override
  _BasicReviewState createState() => _BasicReviewState();
}

class _BasicReviewState extends State<BasicReview> {
  final DBManager2 dbManager2 = DBManager2();
  List<nd_title>? list;
  PageController pageController = PageController();

  // final Stream<QuerySnapshot> users =
  //     FirebaseFirestore.instance.collection("users").snapshots();
  // final TTS = FlutterTts();

  // Future S(X) async {
  //   await TTS.speak(X);
  // }

  int N = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Firstpage();
        })).then((value) {
          return true;
        });
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Firstpage()));
                },
                icon: Icon(Icons.clear_sharp)),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.flip_to_front)),
            ]),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: FutureBuilder(
            future: dbManager2.getnd_TitleList(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                list = snapshot.data;
                return PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list!.length,
                    itemBuilder: (context, index) {
                      nd_title ttl = list![index];
                      return PageView(
                        controller: pageController,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        onPageChanged: (number) {
                          // print('Page number is ' + number.toString());
                        },
                        children: [
                          Container(
                            child: Card(
                              color: Colors.blue,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.favorite))),
                                  Text(
                                    '${ttl.term}',
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
                            child: Card(
                              color: Colors.green,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    "${ttl.defination}",
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
                                        heroTag: 'true',
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
                      );
                    });
              } else {
                return Container();
              }
            },
          )),

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
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width / 3,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        N = N + 1;
                      });
                    },
                    child: Text("Hard"),
                    color: Colors.red,
                  ),
                ),
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width / 3,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        N = N + 1;
                      });
                    },
                    child: Text("Normal"),
                    color: Colors.blue,
                  ),
                ),
                Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width / 3,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        N = N + 1;
                      });
                    },
                    child: Text("Easy"),
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
        ])),
      ),
    );
  }
}
