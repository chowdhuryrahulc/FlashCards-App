// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';

class select_definition extends StatefulWidget {
  String? currentSetUsedForDatabaseSearch;
  select_definition({
    Key? key,
    this.currentSetUsedForDatabaseSearch,
  }) : super(key: key);

  @override
  _select_definitionState createState() => _select_definitionState();
}

bool switchValue1 = false;
bool switchValue2 = false;
bool switchValue3 = false;
bool switchValue4 = false;

class _select_definitionState extends State<select_definition>
    with SingleTickerProviderStateMixin {
  AnimationController? slideAnimationController;

  @override
  void initState() {
    slideAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    slideAnimationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    slideAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          insetPadding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.width / 1.7,
                              horizontal: 20),
                          child: Scaffold(
                            appBar: AppBar(
                              leading: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.close)),
                            ),
                            body: SizedBox(
                              // height: 50,
                              child: Column(
                                children: [
                                  dialogListTile(
                                      'Reversed review', switchValue1),
                                  dialogListTile(
                                      'Reveal random side', switchValue2),
                                  dialogListTile(
                                      'Show only image', switchValue3),
                                  dialogListTile(
                                      'Auto read cards', switchValue4)
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                icon: Icon(Icons.settings))
          ],
        ),
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                .animate(slideAnimationController!),
            child: Column(
              children: [
                Container(
                  height: 350,
                  color: Colors.white,
                  margin: EdgeInsets.all(7.0),
                  child: Center(
                    child: Text('Terminator'),
                  ),
                ),
                OptionWidget('Option 1'),
                OptionWidget('Option 2'),
                OptionWidget('Option 3'),
                OptionWidget('Option 4'),
              ],
            ),
          ),
        ));
  }

  ListTile dialogListTile(String title, bool switchValue) {
    return ListTile(
      leading: Text(title),
      trailing: Switch(
          value: switchValue,
          onChanged: (switchValue) {
            setState(() {
              switchValue = !switchValue;
            });
          }),
    );
  }
}

class OptionWidget extends StatefulWidget {
  final String textInput;
  const OptionWidget(
    this.textInput, {
    Key? key,
  }) : super(key: key);

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool visible = false;
  Color containerColor = Colors.white;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 7.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller!.reverse();
        }
      });
    return AnimatedBuilder(
        animation: offsetAnimation,
        builder: (buildContext, child) {
          return Container(
            margin: EdgeInsets.only(
                left: offsetAnimation.value + 7.0,
                right: 7.0 - offsetAnimation.value,
                bottom: 7.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                  color: containerColor,
                  child: Center(
                    child: GestureDetector(
                        onTap: () {
                          controller!.forward(from: 0.0);
                          visible = true;
                          containerColor = Colors.red;
                        },
                        child: Text(widget.textInput)),
                  ),
                ),
                Visibility(
                    visible: visible,
                    child: Container(
                      color: containerColor,
                      height: 50,
                    ))
              ],
            ),
          );
        });
  }
}
