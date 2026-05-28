class PostModel{
  int id;
  String title;
  String body;

  PostModel({
    required this.id,
    required this.title,
    required this.body
  });

  // membuat factory method
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'], 
      title: json['title'], 
      body: json['body']
    );
  }
}