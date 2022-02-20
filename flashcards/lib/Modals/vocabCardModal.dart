import 'dart:typed_data';

class VocabCardModal {
  int? nd_id;
  String term;
  String defination;
  String? example;
  String? url;
  int? favorite;
  String? current_set;
  int? archive;
  Uint8List? picture;

  VocabCardModal(
      {this.nd_id,
      required this.term,
      required this.defination,
      this.example,
      this.url,
      this.favorite,
      this.current_set,
      this.archive,
      this.picture});
  Map<String, dynamic> toMap() {
    return {
      'nd_id': nd_id,
      'term': term,
      'defination': defination,
      'example': example,
      'url': url,
      'favorite': favorite,
      'current_set': current_set,
      'archive': archive,
      'picture': picture
    };
  }

  Map<String, String> toRenameMap(String newSet) {
    return {
      'current_set': newSet,
    };
  }

  Map<String, dynamic> toFavoriteMap(int favorite) {
    return {
      'nd_id': nd_id,
      'favorite': favorite,
    };
  }
}
