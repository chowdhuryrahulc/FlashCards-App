import 'dart:io';

import 'package:flashcards/views/whiteBoardReview.dart';
import 'package:flutter/material.dart';

addDrawing(BuildContext context) {
  List<DrawingPoints>? points = [];
  double strokeWidth = 3.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  Color color = Colors.black;
  GlobalKey stickeyKeyX = GlobalKey();

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.all(20),
            child: Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.check)),
                  ]),
              body: Column(
                children: [
                  Expanded(
                      key: stickeyKeyX,
                      child: Container(
                        color: Colors.white,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              final keyContext = stickeyKeyX.currentContext;
                              RenderBox renderBox =
                                  keyContext!.findRenderObject() as RenderBox;
                              points.add(DrawingPoints(
                                  points: renderBox
                                      .globalToLocal(details.globalPosition),
                                  paint: Paint()
                                    ..strokeCap = strokeCap
                                    ..isAntiAlias = true
                                    ..color = color
                                    ..strokeWidth = strokeWidth));
                            });
                          },
                          onPanStart: (details) {
                            setState(() {
                              final keyContext = stickeyKeyX.currentContext;
                              RenderBox renderBox =
                                  keyContext!.findRenderObject() as RenderBox;
                              points.add(DrawingPoints(
                                  points: renderBox
                                      .globalToLocal(details.globalPosition),
                                  paint: Paint()
                                    ..strokeCap = strokeCap
                                    ..isAntiAlias = true
                                    ..color = Colors.black
                                    ..strokeWidth = strokeWidth));
                            });
                          },
                          onPanEnd: (details) {
                            setState(() {
                              points.add(DrawingPoints(points: null));
                            });
                          },
                          child: CustomPaint(
                            size: Size.infinite,
                            painter: DrawingPainter(
                              pointsList: points,
                            ),
                          ),
                        ),
                      )),
                  Row(
                    children: [
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                strokeWidth = 3.0;
                              });
                            },
                            icon: Icon(Icons.brightness_1, size: 7)),
                      ),
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                strokeWidth = 7.0;
                              });
                            },
                            icon: Icon(Icons.brightness_1, size: 15)),
                      ),
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(Icons.undo)),
                      ),
                      Container(
                        height: 56,
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.redo)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.purple;
                          });
                        },
                        child: Container(
                          height: 56,
                          color: Colors.purple,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.green;
                          });
                        },
                        child: Container(
                          height: 56,
                          color: Colors.green,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.red;
                          });
                        },
                        child: Container(
                          color: Colors.red,
                          height: 56,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.yellow;
                          });
                        },
                        child: Container(
                          color: Colors.yellow,
                          height: 56,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.blue;
                          });
                        },
                        child: Container(
                          height: 56,
                          color: Colors.blue,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.lightGreen;
                          });
                        },
                        child: Container(
                          height: 56,
                          color: Colors.lightGreen,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.red;
                          });
                        },
                        child: Container(
                          color: Colors.red,
                          height: 56,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            color = Colors.black;
                          });
                        },
                        child: Container(
                          color: Colors.black,
                          height: 56,
                          width: (MediaQuery.of(context).size.width - 40) / 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}
