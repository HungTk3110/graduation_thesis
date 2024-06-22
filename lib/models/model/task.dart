class TaskEntity {
  dynamic id;
  String? title;
  int? color;
  String? dateStart;
  String? dateEnd;
  String? note;
  String? category;
  List<String>? documents;
  bool? doneTask;

  TaskEntity({
    this.id,
    this.title,
    this.color,
    this.dateStart,
    this.dateEnd,
    this.category,
    this.documents,
    this.note,
    this.doneTask,
  });

  TaskEntity.fromDbMap(dynamic obj) {
    id = obj['_id'];
    title = obj?['title'];
    color = obj?['color'];
    dateStart = obj?['dateStart'];
    dateEnd = obj?['dateEnd'];
    category = obj?['category'];
    documents = obj?['documents'];
    note = obj?['note'];
    doneTask = obj?['doneTask'];
  }

  Map<String, dynamic> toDbMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'color': color,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'category': category,
      'documents': documents,
      'note': note,
      'doneTask': doneTask,
    };
  }
}
