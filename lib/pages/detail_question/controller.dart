part of 'imports.dart';

class DetailQuestionController extends ChangeNotifier {
  final QuestionModel question;
  final TestModel test;

  DetailQuestionController(this.question, this.test);

  Future<void> delete(BuildContext context) async {
    HapticFeedback.mediumImpact();
    QuestionDBService().deleteQuestion(question);
    Navigator.pop(context);
    Navigator.pop(context, "update");
  }

  void update(QuestionModel newQuestion) {
    question.question = newQuestion.question;
    question.answer = newQuestion.answer;
    question.variantOne = newQuestion.variantOne;
    question.variantTwo = newQuestion.variantTwo;
    question.variantThree = newQuestion.variantThree;
    notifyListeners();
  }

  void share() {
    List<String> variants = [
      question.answer,
      question.variantOne,
      question.variantTwo,
      question.variantThree
    ];
    variants.shuffle();
    String result = "❓ ${question.question}\n";
    result += "🇦 ${variants[0]}\n";
    result += "🇧 ${variants[1]}\n";
    result += "🇨 ${variants[2]}\n";
    result += "🇩 ${variants[3]}\n";
    Share.share(result);
  }
}
