import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class WhiteBoardReview extends StatefulWidget {
  String? currentSetUsedForDatabaseSearch;
  WhiteBoardReview({
    Key? key,
    this.currentSetUsedForDatabaseSearch,
  }) : super(key: key);

  @override
  _WhiteBoardReviewState createState() => _WhiteBoardReviewState();
}

class _WhiteBoardReviewState extends State<WhiteBoardReview> {
  bool vissible = true;
  List<DrawingPoints>? points = [];
  double strokeWidth = 3.0;
  BlendMode blendMode = BlendMode.darken;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  GlobalKey stickeyKey = GlobalKey();
  int X1 = 0;
  int X2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'OSAKA',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Visibility(
        visible: !vissible,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[400],
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'KAMAMOTO',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      Expanded(
          key: stickeyKey,
          child: Container(
            color: Colors.white,
            child: GestureDetector(
              onPanStart: (details) {
                X1 = X2;
                print('Starting X1 value: ${X1}');
              },
              onPanUpdate: (details) {
                setState(() {
                  X2++;
                  final keyContext = stickeyKey.currentContext;
                  RenderBox renderBox =
                      keyContext!.findRenderObject() as RenderBox;
                  points!.add(DrawingPoints(
                      offsetDrawingPoints:
                          renderBox.globalToLocal(details.globalPosition),
                      paint: Paint()
                        ..strokeCap = strokeCap
                        ..isAntiAlias = true
                        ..color = Colors.blue
                        ..blendMode = blendMode
                        ..strokeWidth = strokeWidth));
                });
              },
              onPanEnd: (details) {
                setState(() {
                  print('Ending X2 value: ${X2}');
                  points!.add(DrawingPoints(offsetDrawingPoints: null));
                });
              },
              child: CustomPaint(
                // can put a child with length and breth. (Container)
                // Size.infinite is the reson why it paints above the TextField.
                // delete Size.infinite
                // color the Container white and remove topMost container.

                // painter paints below child widget.
                // forgroundPainter paints on top of child widget.

                size: Size.infinite,
                painter: DrawingPainter(
                  listOfDrawingPoints: points!,
                ),
              ),
            ),
          )),
      Row(
        children: [
          Container(
            height: 56,
            color: Colors.lightGreen,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    strokeWidth = 3.0;
                    blendMode = BlendMode.darken;
                  });
                },
                icon: Icon(Icons.brightness_1, size: 7)),
          ),
          Container(
            height: 56,
            color: Colors.lightGreen,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    strokeWidth = 7.0;
                    blendMode = BlendMode.darken;
                  });
                },
                icon: Icon(Icons.brightness_1, size: 15)),
          ),
          Container(
            color: Colors.lightGreen,
            height: 56,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    // blendMode = BlendMode.clear;

                    // points!.removeWhere((element) => true);
                    // if (points!.length > 0) {
                    // if (X != null) {
                    print('Delete between ${X1} and ${X2}');
                    points!.removeRange(X1, X2);
                    X2 = X1;
                    // X1 = X1 - (X2 - X1);
                    // print(points!.removeLast());
                    // }
                  });
                },
                icon: Icon(Icons.undo)),
          ),
          Container(
            color: Colors.lightGreen,
            height: 56,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.redo)),
          ),
        ],
      ),
      Visibility(
        visible: vissible,
        child: InkWell(
          onTap: () {
            setState(() {
              vissible = !vissible;
            });
          },
          child: Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'SHOW ANSWER',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )),
        ),
      ),
      Visibility(
        visible: !vissible,
        child: Container(
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
                      // N = N + 1;
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
                      // N = N + 1;
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
                      // N = N + 1;
                    });
                  },
                  child: Text("Easy"),
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    ]));
  }
}

class DrawingPainter extends CustomPainter {
  DrawingPainter({this.listOfDrawingPoints});
  List<DrawingPoints>? listOfDrawingPoints;
  List<Offset> offsetPoints = [];
  // Path path = Path();
  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.largest, Paint());
    // double x, y;
    for (int i = 0; i < listOfDrawingPoints!.length - 1; i++) {
      if (listOfDrawingPoints![i].offsetDrawingPoints != null &&
          listOfDrawingPoints![i + 1].offsetDrawingPoints != null) {
        canvas.drawLine(
            listOfDrawingPoints![i].offsetDrawingPoints!,
            listOfDrawingPoints![i + 1].offsetDrawingPoints!,
            listOfDrawingPoints![i].paint!);
        canvas.drawCircle(
            listOfDrawingPoints![i].offsetDrawingPoints!,
            listOfDrawingPoints![i].paint!.strokeWidth / 2,
            listOfDrawingPoints![i].paint!);

        // x = pointsList![i].points!.dx;
        // y = pointsList![i].points!.dy;
        // path.lineTo(x, y);
        // canvas.drawPath(path, pointsList![i].paint!);

        // print(pointsList![i].points!.dx);
        // Offset? startPoints[x , y] = pointsList![i].points:
// from here you get double value

        // canvas.drawLine(p1, p2, paint)
        // canvas.drawPath(path, paint)
        // path.lineTo(x, y)
        // path.lineTo(x, y);
      }
      // for drawing single points
      else if (listOfDrawingPoints![i].offsetDrawingPoints != null &&
          listOfDrawingPoints![i + 1].offsetDrawingPoints == null) {
        offsetPoints.clear();
        offsetPoints.add(listOfDrawingPoints![i].offsetDrawingPoints!);
        offsetPoints.add(Offset(
            listOfDrawingPoints![i].offsetDrawingPoints!.dx + 0.1,
            listOfDrawingPoints![i].offsetDrawingPoints!.dy + 0.1));
        canvas.drawPoints(
            PointMode.points, offsetPoints, listOfDrawingPoints![i].paint!);
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint? paint;
  Offset? offsetDrawingPoints;
  DrawingPoints({this.offsetDrawingPoints, this.paint});
}
