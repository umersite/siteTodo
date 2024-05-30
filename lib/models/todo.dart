class Todo{
  final String date;
  final String task;

  Todo({required this.date, required this.task});

  Todo.fromJson(Map<dynamic,dynamic> json):
        date = json['date'] as String,
        task = json['task'] as String;

  Map<dynamic,dynamic> toJson() => <dynamic,dynamic>{
    'date': date,
    'task': task
  };

  Map<String, dynamic> toMap()=><String, dynamic>{
    'date': date,
    'task': task
  };
}