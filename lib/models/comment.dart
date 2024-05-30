class Comment{
  final String name;
  final String comment;

  Comment({required this.name, required this.comment});

  Comment.fromJson(Map<dynamic,dynamic> json):
        name = json['name'] as String,
        comment = json['comment'] as String;

  Map<dynamic,dynamic> toJson() => <dynamic,dynamic>{
    'name': name,
    'comment': comment
  };

  Map<String, dynamic> toMap()=><String, dynamic>{
    'name': name,
    'comment': comment
  };
}