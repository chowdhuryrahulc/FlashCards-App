// Get the data, Put the data
import 'dart:typed_data';
import 'package:flashcards/Modals/headlineModal.dart';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flutter/material.dart';

import '../database/VocabDatabase.dart';

class createSetLanguageControl extends ChangeNotifier {
  String selectedLanguage = 'English';
  updateSelectedLanguage(String newLanguage) {
    selectedLanguage = newLanguage;
    print(selectedLanguage);
    notifyListeners();
  }

  // notifyListeners();
}

class pictureBLOBControl extends ChangeNotifier {
  Uint8List? uint8list;

  makeIZero() {
    uint8list = null;
    notifyListeners();
  }

  void sendPictureUint8List(Uint8List? uint8List) {
    uint8list = uint8List;
    notifyListeners();
  }
}

class darktheme extends ChangeNotifier {
  bool _dark = false;
  bool get dark => _dark;
  change(value) {
    _dark = value;
    notifyListeners();
  }
}

class iMatchControl extends ChangeNotifier {
  Color cardWhiteColor = Colors.white;

  ColorcardColorChanger(Color cardColor) {
    if (cardColor == Colors.white) {
      return cardWhiteColor == Colors.blue;
    } else {
      return cardWhiteColor == Colors.white;
    }

    // cardWhiteColor = !cardWhiteColor;
    // notifyListeners();
  }

  notifyListeners();
}

class gridViewVisibleControl extends ChangeNotifier {
  bool visibleTernaryFAB = true;
  final VocabDatabase dbManager2 = VocabDatabase();
  int? favoriteToggle;

  updateFavoriteTitle(favoriteToggle, VocabCardModal list) {
    if (favoriteToggle == 0) {
      dbManager2.updateFavoriteTitle(list, 1);
      favoriteToggle == 1;
    } else if (favoriteToggle == 1) {
      dbManager2.updateFavoriteTitle(list, 0);
      favoriteToggle == 0;
    }
    notifyListeners();
  }

  updateVisibleTernaryFAB(bool visible) {
    visibleTernaryFAB = visible;
    notifyListeners();
  }
}

class createSetFutureHeadlineControl extends ChangeNotifier {
  Headlines? headline;

  makeIZero() {
    headline == null;
    notifyListeners();
  }

  Future updateFutureHeadline(Headlines head) async {
    print('HEAD ID ${head.id}');
    headline = head;
    notifyListeners();
  }

  notifyListeners();
}

class iSelectDefinationControl extends ChangeNotifier {
  int i = 0;
  bool visible = false;

  makeIZero() {
    i = 0;
    notifyListeners();
  }

  increment(List<VocabCardModal>? list) {
    if (i < list!.length - 1) {
      i++;
      visible = false;
    }
    notifyListeners();
  }
}

class iWhiteBoardReviewControl extends ChangeNotifier {
  int i = 0;
  bool visible = false;
  increment(List<VocabCardModal>? list) {
    if (i < list!.length - 1) {
      i++;
      visible = false;
    }
    notifyListeners();
  }

  makeIZero() {
    i = 0;
    notifyListeners();
  }

  updateVisible() {
    visible = true;
    notifyListeners();
  }
}

class iAudioPlayerControl extends ChangeNotifier {
  int i = 0;
  bool togglePlay = false;
  decrement() {
    if (i != 0) {
      i--;
    }
    notifyListeners();
  }

  makeIZero() {
    i = 0;
    notifyListeners();
  }

  togglePlayer(List<VocabCardModal>? list) async {
    togglePlay = !togglePlay;
    for (i; i < list!.length - 1 && togglePlay == true; await i++) {
      await Future.delayed(Duration(milliseconds: 1000));
      if (i == (list.length - 1)) {
        break;
      }
      ;
      notifyListeners();
    }
    ;
    if (i == (list.length - 1)) {
      togglePlay = false;
    }
  }

  increment(List<VocabCardModal>? list) {
    if (i < list!.length - 1) {
      i++;
    }
    notifyListeners();
  }
}

class currentSetX extends ChangeNotifier {
  String? currentSet;
}
