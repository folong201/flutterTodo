class Todo {
  final int? id;
  final String? title;
  final String? description;
  Todo({this.id, this.title, this.description});
  Todo.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      'title': title,
      'description': description,
    };
  }
toList(){}
}
