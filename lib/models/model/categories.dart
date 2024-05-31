class Categories {
  String? title;
  int? color;

  Categories({
    this.title,
    this.color,
  });

  Categories.fromDbMap(dynamic obj) {
    title = obj?['title'];
    color = obj?['color'];
  }

  Map<String, dynamic> toDbMap() {
    return <String, dynamic>{
      'title': title,
      'color': color,
    };
  }
}
