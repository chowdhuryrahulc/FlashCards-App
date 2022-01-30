// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flashcards/database/VocabDatabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class matchCards extends StatefulWidget {
  final String? currentSetUsedForDatabaseSearch;
  const matchCards({
    Key? key,
    this.currentSetUsedForDatabaseSearch,
  }) : super(key: key);

  @override
  _matchCardsState createState() => _matchCardsState();
}

class _matchCardsState extends State<matchCards> with TickerProviderStateMixin {
  final VocabDatabase dbManager2 = VocabDatabase();
  List<VocabCardModal>? list;
  AnimationController? leftSlideAnimationController;
  AnimationController? rightSlideAnimationController;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _rightKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
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

  void _removeItem(String _item, int index, bool left) {
    // final int _index = index - 1;
    // _list.removeAt(index);
    left
        ? _listKey.currentState!.removeItem(index,
            (context, animation) => _buildItem(_item, index, left, animation))
        : _rightKey.currentState!.removeItem(
            index,
            (context, animation) =>
                _buildItem(index.toString(), index, left, animation));
  }

  @override
  Widget build(BuildContext context) {
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  animatedListColumn(true, list!),
                  animatedListColumn(false, list!),
                ],
              );
            } else {
              return Container();
            }
          }),
    );
  }

  animatedListColumn(bool left, List<VocabCardModal> list) {
    return SlideTransition(
      position: Tween<Offset>(
              begin: left ? Offset(-1, 0) : Offset(1, 0), end: Offset.zero)
          .animate(left
              ? leftSlideAnimationController!
              : rightSlideAnimationController!),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: AnimatedList(
          shrinkWrap: true,
          key: left ? _listKey : _rightKey,
          initialItemCount: 10,
          itemBuilder:
              (BuildContext context, int index, Animation<double> animation) {
            return _buildItem(left ? list[index].term : list[index].defination,
                index, left, animation);
          },
        ),
      ),
    );
  }

  Widget _buildItem(
      String _item, int index, bool left, Animation<double> _animation) {
    Color cardColor = Provider.of<iMatchControl>(context).cardWhiteColor;
    print('cardColor: $cardColor');
    return SizeTransition(
      sizeFactor: _animation,
      child: InkWell(
        onTap: () {
          // Provider.of<iMatchControl>(context, listen: false).cardColorChanger();
          // cardWhiteColor = false;
          // _removeItem(_item, index, left);
          // print(index);
        },
        child: Card(
          color: cardColor,
          child: ListTile(
            title: Text(
              _item,
            ),
          ),
        ),
      ),
    );
  }
}
