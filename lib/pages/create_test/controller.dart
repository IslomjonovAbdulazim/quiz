part of 'imports.dart';

class CreateTestController extends ChangeNotifier {
  final String userId;
  final TestModel? test;
  late TextEditingController titleController;
  String? problem;
  bool isLoading = false;

  CreateTestController(this.userId, [this.test]) {
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
      changeIsLoading();
      if (test == null) {
        await create();
      } else {
        await edit();
      }
      changeIsLoading();
      return true;
    }
  }

  Future<void> create() async {
    TestModel test = TestModel(
      id: "",
      author: userId,
      title: titleController.text.trim(),
      onLive: null,
    );
    DBService db = DBService();
    await db.createTest(test);
  }

  Future<void> edit() async {
    test!.title = titleController.text.trim();
    DBService db = DBService();
    await db.updateTest(test!);
  }

  void check() {
    if (titleController.text.trim().isEmpty) {
      problem = "Title cannot be empty";
    } else {
      problem = null;
    }
  }

  void init() {
    titleController = TextEditingController(text: test?.title);
    notifyListeners();
  }

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}
