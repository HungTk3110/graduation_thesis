class Categories {
  dynamic id;
  String? title;
  int? color;
  String? createAt;

  Categories({
    this.id,
    this.title,
    this.color,
    this.createAt,
  });

  Categories.fromDbMap(dynamic obj) {
    id = obj['_id'];
    title = obj?['title'];
    color = obj?['color'];
    createAt = obj?['createAt'];
  }

  Map<String, dynamic> toDbMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'color': color,
      'createAt': createAt,
    };
  }
}
