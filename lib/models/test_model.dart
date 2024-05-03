class TestModel {
  late String id;
  late String author;
  late String title;
  int? onLive;

  TestModel({
    required this.id,
    required this.author,
    required this.title,
    required this.onLive,
  });

  TestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    title = json['title'];
    onLive = json['onLive'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        "title": title,
        'onLive': onLive,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
