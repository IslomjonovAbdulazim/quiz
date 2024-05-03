part of 'imports.dart';

class DetailTestController extends ChangeNotifier {
  final TestModel test;
  List<QuestionModel> questions = [];
  late LiveModel live;
  bool isLoading = false;
  int code = 0;

  DetailTestController(this.test) {
    init();
  }

  void finishTheTest() async {
    isLoading = true;
    code = 0;
    notifyListeners();
    live.end = DateTime.now();
    await TestDBService().deleteLive(test.onLive!.toString(), live);
    test.onLive = null;
    await DBService().updateTest(test);
    isLoading = false;
    notifyListeners();
  }

  void share() {
    String result = '🌟 ${test.title}\n\n';
    for (final question in questions) {
      List<String> variants = [
        question.answer,
        question.variantOne,
        question.variantTwo,
        question.variantThree
      ];
      variants.shuffle();
      String txt = "❓ ${question.question}\n";
      txt += "🇦 ${variants[0]}\n";
      txt += "🇧 ${variants[1]}\n";
      txt += "🇨 ${variants[2]}\n";
      txt += "🇩 ${variants[3]}\n";
      result += '$txt\n\n';
    }
    Share.share(result);
  }

  Future<void> startLive() async {
    isLoading = true;
    notifyListeners();
    generateCode();
    live = LiveModel(
      testId: test.id,
      author: test.author,
      code: code,
      start: DateTime.now(),
      end: DateTime.now(),
    );
    test.onLive = code;
    TestDBService database = TestDBService();
    await database.startLive(test, live);
    isLoading = false;
    notifyListeners();
  }

  void generateCode() {
    for (int i = 0; i <= 3; i++) {
      code = code * 10 + Random().nextInt(9);
    }
    notifyListeners();
  }

  void init() async {
    isLoading = true;
    notifyListeners();
    QuestionDBService database = QuestionDBService();
    questions = await database.getAllQuestions(test.author, test.id);
    isLoading = false;
    notifyListeners();
  }
}
