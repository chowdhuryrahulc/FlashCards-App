import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flutter/material.dart';

class match_cards extends StatefulWidget {
  String? currentSetUsedForDatabaseSearch;
  match_cards({
    Key? key,
    this.currentSetUsedForDatabaseSearch,
  }) : super(key: key);

  @override
  State<match_cards> createState() => _match_cardsState();
}

class _match_cardsState extends State<match_cards> {
  final VocabDatabase dbManager2 = VocabDatabase();
  List<VocabCardModal>? list;

  @override
  Widget build(BuildContext context) {
    // int i = context.watch<iMatchControl>().i;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: FutureBuilder(
          future: widget.currentSetUsedForDatabaseSearch == null
              ? dbManager2.getAllVocabCards()
              : dbManager2.getVocabCardsusingCurrentSet(
                  widget.currentSetUsedForDatabaseSearch),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              list = snapshot.data;
              return SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textContainer(false, list!),
                    textContainer(true, list!),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

class textContainer extends StatefulWidget {
  final List<VocabCardModal> list;
  final bool rightDirection; // left =false, right = true
  const textContainer(this.rightDirection, this.list, {Key? key})
      : super(key: key);

  @override
  _textContainerState createState() => _textContainerState();
}

class _textContainerState extends State<textContainer>
    with TickerProviderStateMixin {
  AnimationController? leftSlideAnimationController;
  AnimationController? rightSlideAnimationController;

  @override
  void initState() {
    widget.list.shuffle();
    leftSlideAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    rightSlideAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    leftSlideAnimationController!.forward();
    rightSlideAnimationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    leftSlideAnimationController!.dispose();
    rightSlideAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SlideTransition(
        position: Tween<Offset>(
                begin: widget.rightDirection ? Offset(1, 0) : Offset(-1, 0),
                end: Offset.zero)
            .animate(widget.rightDirection
                ? rightSlideAnimationController!
                : leftSlideAnimationController!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < 10 && i <= widget.list.length - 1; i++)
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Center(
                    child: Text(
                        widget.rightDirection
                            ? widget.list[i].defination
                            : widget.list[i].term,
                        style: TextStyle(fontSize: 20))),
              ),
          ],
        ),
      ),
    );
  }
}
