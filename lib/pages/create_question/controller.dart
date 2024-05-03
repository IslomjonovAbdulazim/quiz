part of 'imports.dart';

class CreateQuestionController extends ChangeNotifier {
  final TestModel test;
  final QuestionModel? question;
  String? problem;
  bool isLoading = false;

  late TextEditingController questionController;
  late TextEditingController answerController;
  late TextEditingController variantOneController;
  late TextEditingController variantTwoController;
  late TextEditingController variantThreeController;

  FocusNode questionFocus = FocusNode();
  FocusNode answerFocus = FocusNode();
  FocusNode variantOneFocus = FocusNode();
  FocusNode variantTwoFocus = FocusNode();
  FocusNode variantThreeFocus = FocusNode();

  CreateQuestionController(this.test, [this.question]) {
    init();
  }

  Future<bool> save(BuildContext context) async {
    check();
    if (problem != null) {
      HapticFeedback.vibrate();
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(problem!),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    } else {
      isLoading = true;
      notifyListeners();
      if (question == null) {
        await create();
      } else {
        await edit();
      }
      isLoading = false;
      notifyListeners();
    }
    return true;
  }

  void check() {
    if (questionController.text.trim().isEmpty) {
      problem = "Question cannot be empty";
    } else if (answerController.text.trim().isEmpty) {
      problem = "Answer cannot be empty";
    } else if (variantOneController.text.trim().isEmpty) {
      problem = "Variant one cannot be empty";
    } else if (variantTwoController.text.trim().isEmpty) {
      problem = "Variant two cannot be empty";
    } else if (variantThreeController.text.trim().isEmpty) {
      problem = "Variant three cannot be empty";
    } else {
      problem = null;
    }
  }

  Future<void> edit() async {
    question!.question = questionController.text.trim();
    question!.variantOne = variantOneController.text.trim();
    question!.variantTwo = variantTwoController.text.trim();
    question!.variantThree = variantThreeController.text.trim();
    question!.answer = answerController.text.trim();
    QuestionDBService database = QuestionDBService();
    await database.updateQuestion(question!);
  }

  Future<void> create() async {
    QuestionModel question = QuestionModel(
      id: '-',
      testId: test.id,
      author: test.author,
      question: questionController.text.trim(),
      variantOne: variantOneController.text.trim(),
      variantTwo: variantTwoController.text.trim(),
      variantThree: variantThreeController.text.trim(),
      answer: answerController.text.trim(),
    );
    QuestionDBService database = QuestionDBService();
    await database.createQuestion(question);
  }

  void init() {
    questionController = TextEditingController(text: question?.question);
    answerController = TextEditingController(text: question?.answer);
    variantOneController = TextEditingController(text: question?.variantOne);
    variantTwoController = TextEditingController(text: question?.variantTwo);
    variantThreeController =
        TextEditingController(text: question?.variantThree);
    notifyListeners();
  }

  @override
  void dispose() {
    questionFocus.dispose();
    questionController.dispose();
    answerFocus.dispose();
    answerController.dispose();
    variantOneFocus.dispose();
    variantOneController.dispose();
    variantTwoFocus.dispose();
    variantTwoController.dispose();
    variantThreeFocus.dispose();
    variantThreeController.dispose();
    super.dispose();
  }
}
