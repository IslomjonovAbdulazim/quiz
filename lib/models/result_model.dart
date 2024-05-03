class ResultModel {
  late String id;
  late String userId;
  late String title;
  late int corrects;
  late int attempts;

  ResultModel({
    required this.title,
    required this.id,
    required this.userId,
    required this.corrects,
    required this.attempts,
  });

  ResultModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    userId = json['userId'];
    corrects = json['corrects'];
    attempts = json['attempts'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'userId': userId,
        'corrects': corrects,
        'attempts': attempts,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
