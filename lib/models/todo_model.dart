class TodoModel {
  String title;
  String description;
  String date;
  int id;
  TodoModel({
    this.id = 0,
    required this.title,
    required this.description,
    required this.date,
  });
}
