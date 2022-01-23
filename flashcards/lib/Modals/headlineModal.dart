class Headlines {
  int? id;
  String name;
  String description;
  int? archive;

  Headlines(
      {this.id, required this.name, required this.description, this.archive});
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'description': description};
  }

  Map<String, dynamic> toArchiveMap(int archive) {
    return {
      'id': id,
      'archive': archive,
    };
  }
}
