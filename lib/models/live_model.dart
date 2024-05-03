class LiveModel {
  late String testId;
  late String author;
  late int code;
  late DateTime start;
  late DateTime end;

  LiveModel({
    required this.testId,
    required this.author,
    required this.code,
    required this.start,
    required this.end,
  });

  LiveModel.fromJson(Map<String, dynamic> json) {
    testId = json['testId'];
    author = json['author'];
    code = json['code'];
    start = DateTime.parse(json['start']);
    end = DateTime.parse(json['end']);
  }

  Map<String, dynamic> toJson() => {
        'testId': testId,
        'author': author,
        'code': code,
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
