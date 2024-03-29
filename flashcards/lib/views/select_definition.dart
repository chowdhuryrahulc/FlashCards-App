// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';

class select_definition extends StatefulWidget {
  List<VocabCardModal> vocabCardModalList;

  select_definition({Key? key, required this.vocabCardModalList})
      : super(key: key);

  @override
  _select_definitionState createState() => _select_definitionState();
}

bool switchValue1 = false;
bool switchValue2 = false;
bool switchValue3 = false;
bool switchValue4 = false;

class _select_definitionState extends State<select_definition>
    with SingleTickerProviderStateMixin {
  final VocabDatabase dbManager2 = VocabDatabase();
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
    return ChangeNotifierProvider(
      create: (_) => iSelectDefinationControl(),
      child: Builder(builder: (BuildContext context) {
        int i = context.watch<iSelectDefinationControl>().i;
        var listABC = generateRandomOptions(widget.vocabCardModalList, i);
        return WillPopScope(
          onWillPop: () async {
            context.read<iSelectDefinationControl>().makeIZero();
            return true;
          },
          child: Scaffold(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetPadding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.width / 1.7,
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
              body: SingleChildScrollView(
                child: SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                          .animate(slideAnimationController!),
                  child: Column(
                    children: [
                      Container(
                        height: 350,
                        color: Theme.of(context).colorScheme.secondary,
                        margin: EdgeInsets.all(7.0),
                        child: Center(
                          child: Text(widget.vocabCardModalList[i].term,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 50)),
                        ),
                      ),
                      OptionWidget(
                          listABC[0],
                          widget.vocabCardModalList[i].defination,
                          widget.vocabCardModalList),
                      OptionWidget(
                          listABC[1],
                          widget.vocabCardModalList[i].defination,
                          widget.vocabCardModalList),
                      OptionWidget(
                          listABC[2],
                          widget.vocabCardModalList[i].defination,
                          widget.vocabCardModalList),
                      OptionWidget(
                          listABC[3],
                          widget.vocabCardModalList[i].defination,
                          widget.vocabCardModalList),
                    ],
                  ),
                ),
              )),
        );
      }),
    );
  }

  ListTile dialogListTile(String title, bool switchValue) {
    return ListTile(
      leading: Text(title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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
  final List<VocabCardModal>? list;
  final VocabCardModal textInput;
  final String answer;

  const OptionWidget(
    this.textInput,
    this.answer,
    this.list, {
    Key? key,
  }) : super(key: key);

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

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
    Color containerColor = Theme.of(context).colorScheme.secondary;
    bool visible = context.watch<iSelectDefinationControl>().visible;
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 7.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller!.reverse();
        }
      });
    return InkWell(
      onTap: () async {
        if (widget.textInput.defination == widget.answer) {
          controller!.forward(from: 0.0);
          containerColor = Colors.green;
          await Future.delayed(Duration(seconds: 2));
          context.read<iSelectDefinationControl>().increment(widget.list);
        } else {
          controller!.forward(from: 0.0);
          visible = true;
          containerColor = Colors.red; //! blackish red in dark theme.
        }
      },
      child: AnimatedBuilder(
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
                      child: Text(widget.textInput.defination,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                    ),
                  ),
                  Visibility(
                      visible: visible,
                      child: Container(
                        color: containerColor,
                        height: 50,
                        child: Center(
                          child: Text(widget.textInput.term,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                        ),
                      ))
                ],
              ),
            );
          }),
    );
  }
}

generateRandomOptions(List<VocabCardModal> list, int i) {
  var r = Random();
  // generating 3 options
  VocabCardModal A = list[r.nextInt(list.length)];
  VocabCardModal B = list[r.nextInt(list.length)];
  VocabCardModal C = list[r.nextInt(list.length)];
  VocabCardModal ANS = list[i];

// suffling 3 optioins
  List<VocabCardModal> listABCandANS = [A, B, C, ANS];
  listABCandANS.shuffle();
  return listABCandANS;
}
