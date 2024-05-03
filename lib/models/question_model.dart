class QuestionModel {
  late String id;
  late String testId;
  late String author;
  late String question;
  late String answer;
  late String variantOne;
  late String variantTwo;
  late String variantThree;

  QuestionModel({
    required this.id,
    required this.testId,
    required this.author,
    required this.question,
    required this.variantOne,
    required this.variantTwo,
    required this.variantThree,
    required this.answer,
  });

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testId = json['testId'];
    author = json['author'];
    question = json['question'];
    variantOne = json['variantOne'];
    variantTwo = json['variantTwo'];
    variantThree = json['variantThree'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'testId': testId,
        'author': author,
        'question': question,
        'variantOne': variantOne,
        'variantTwo': variantTwo,
        'variantThree': variantThree,
        'answer': answer,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
