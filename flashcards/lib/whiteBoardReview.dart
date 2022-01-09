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
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  GlobalKey stickeyKey = GlobalKey();

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
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                final keyContext = stickeyKey.currentContext;
                RenderBox renderBox =
                    keyContext!.findRenderObject() as RenderBox;
                points!.add(DrawingPoints(
                    points: renderBox.globalToLocal(details.globalPosition),
                    paint: Paint()
                      ..strokeCap = strokeCap
                      ..isAntiAlias = true
                      ..color = Colors.black
                      ..strokeWidth = strokeWidth));
              });
            },
            onPanStart: (details) {
              setState(() {
                final keyContext = stickeyKey.currentContext;
                RenderBox renderBox =
                    keyContext!.findRenderObject() as RenderBox;
                points!.add(DrawingPoints(
                    points: renderBox.globalToLocal(details.globalPosition),
                    paint: Paint()
                      ..strokeCap = strokeCap
                      ..isAntiAlias = true
                      ..color = Colors.black
                      ..strokeWidth = strokeWidth));
              });
            },
            onPanEnd: (details) {
              setState(() {
                points!.add(DrawingPoints(points: null));
              });
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: DrawingPainter(
                pointsList: points!,
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
                    points!.removeLast();
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
  DrawingPainter({this.pointsList});
  List<DrawingPoints>? pointsList;
  List<Offset> offsetPoints = [];
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList!.length - 1; i++) {
      if (pointsList![i].points != null && pointsList![i + 1].points != null) {
        canvas.drawLine(pointsList![i].points!, pointsList![i + 1].points!,
            pointsList![i].paint!);
      } else if (pointsList![i].points != null &&
          pointsList![i + 1].points == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList![i].points!);
        offsetPoints.add(Offset(
            pointsList![i].points!.dx + 0.1, pointsList![i].points!.dy + 0.1));
        canvas.drawPoints(
            PointMode.points, offsetPoints, pointsList![i].paint!);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint? paint;
  Offset? points;
  DrawingPoints({this.points, this.paint});
}
