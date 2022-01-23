// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';

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
  final VocabDatabase dbManager2 = VocabDatabase();
  List<VocabCardModal>? list;
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
    int i = context.watch<iSelectDefinationControl>().i;
    return Scaffold(
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
        body: SingleChildScrollView(
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                .animate(slideAnimationController!),
            child: FutureBuilder(
                future: widget.currentSetUsedForDatabaseSearch == null
                    ? dbManager2.getAllVocabCards()
                    : dbManager2.getVocabCardsusingCurrentSet(
                        widget.currentSetUsedForDatabaseSearch),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    list = snapshot.data;
                    var listABC = generateRandomOptions(list!, i);
                    return Column(
                      children: [
                        Container(
                          height: 350,
                          color: Theme.of(context).colorScheme.secondary,
                          margin: EdgeInsets.all(7.0),
                          child: Center(
                            child: Text(list![i].term,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 50)),
                          ),
                        ),
                        OptionWidget(listABC[0], list![i].defination),
                        OptionWidget(listABC[1], list![i].defination),
                        OptionWidget(listABC[2], list![i].defination),
                        OptionWidget(listABC[3], list![i].defination),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ));
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
  final VocabCardModal textInput;
  final String answer;

  const OptionWidget(
    this.textInput,
    this.answer, {
    Key? key,
  }) : super(key: key);

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool visible = false;

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
          // visible = false;
          context.read<iSelectDefinationControl>().increment();
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
  // var X = r.nextInt(list.length);
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
