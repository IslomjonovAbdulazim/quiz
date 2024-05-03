part of 'imports.dart';

class TestController extends ChangeNotifier {
  final String liveCode;
  final UserModel user;
  late ApplicantModel applicant;
  late LiveModel live;

  bool isLoading = true;
  List<QuestionModel> questions = [];
  List<List<String>> variants = [];
  List<String> choices = [];
  int corrects = 0;
  bool? result;

  TestController(this.liveCode, this.user) {
    init();
  }

  int currentQuestion = 0;

  String get getCurrentQuestion {
    return questions[currentQuestion].question;
  }

  bool get getShowResult {
    return currentQuestion == questions.length && questions.length >= 5;
  }

  List<String> get getCurrentVariants {
    return variants[currentQuestion];
  }

  void init() async {
    applicant = ApplicantModel(
      corrects: 0,
      totalAttempts: 0,
      userId: user.id,
      avatar: user.avatar,
      lastname: user.lastname,
      name: user.firstname,
      title: '',
      time: DateTime.now(),
    );
    QuestionDBService database = QuestionDBService();
    live = await TestDBService().getLive(liveCode);
    questions = await database.getAllQuestions(live.author, live.testId);
    final test = await DBService().getSpecificTest(live);
    applicant.title = test.title;
    questions.shuffle();
    for (var question in questions) {
      List<String> options = [
        question.answer,
        question.variantOne,
        question.variantTwo,
        question.variantThree,
      ];
      options.shuffle();
      variants.add(options);
    }
    isLoading = false;
    notifyListeners();
  }

  Color? getColor(String variant) {
    if (result == true && variant == choices.last) {
      return CupertinoColors.systemGreen;
    } else if (result == false && variant == choices.last) {
      return CupertinoColors.systemRed;
    } else if (result != null && variant == questions[currentQuestion].answer) {
      return CupertinoColors.systemGreen;
    }
    return null;
  }

  void select(String variant) {
    choices.add(variant);
    result = variant == questions[currentQuestion].answer;
    if (result == true) {
      HapticFeedback.lightImpact();
      corrects++;
    } else {
      HapticFeedback.heavyImpact();
    }
    notifyListeners();
  }

  void next(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    result = null;
    currentQuestion++;
    applicant.corrects = corrects;
    applicant.totalAttempts = currentQuestion;
    applicant.time = DateTime.now();
    await TestDBService().updateIt(live, applicant);
    isLoading = false;
    notifyListeners();
  }
}
