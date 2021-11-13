import 'package:flutter/material.dart';

class WhiteBoardReview extends StatefulWidget {
  const WhiteBoardReview({Key? key}) : super(key: key);

  @override
  _WhiteBoardReviewState createState() => _WhiteBoardReviewState();
}

class _WhiteBoardReviewState extends State<WhiteBoardReview> {
  bool vissible = true;
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
      Expanded(child: Container()),
      Row(
        children: [
          Container(
            height: 56,
            color: Colors.lightGreen,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.brightness_1, size: 7)),
          ),
          Container(
            height: 56,
            color: Colors.lightGreen,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.brightness_1, size: 15)),
          ),
          Container(
            color: Colors.lightGreen,
            height: 56,
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.undo)),
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
