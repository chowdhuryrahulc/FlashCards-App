// Get the data, Put the data
import 'dart:typed_data';
import 'package:flashcards/Modals/vocabCardModal.dart';
import 'package:flutter/material.dart';

class pictureBLOBControl extends ChangeNotifier {
  Uint8List? uint8list;

  void sendPictureUint8List(Uint8List? uint8List) {
    uint8list = uint8List;
    print(uint8list);
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
  int i = 0;
  increment() {
    i++;
    notifyListeners();
  }
}

class gridViewVisibleControl extends ChangeNotifier {
  bool visibleTernaryFAB = true;

  updateVisibleTernaryFAB(bool visible) {
    visibleTernaryFAB = visible;
    notifyListeners();
  }
}

class iSelectDefinationControl extends ChangeNotifier {
  int i = 0;
  increment(List<VocabCardModal>? list) {
    if (i < list!.length - 1) {
      i++;
    }
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

  togglePlayer(List<VocabCardModal>? list) async {
    togglePlay = !togglePlay;
    for (int j = 0; j < list!.length - 1 && togglePlay == true; j++) {
      await Future.delayed(Duration(milliseconds: 1000));
      i++;
      notifyListeners();
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
