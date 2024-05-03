part of 'imports.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = false;
  late UserModel user;
  List<TestModel> tests = [];

  HomeController() {
    init();
  }

  void init() async {
    isLoading = true;
    notifyListeners();
    DBService db = DBService();
    user = (await db.getUser()) ??
        UserModel(
          id: "fake",
          avatar: null,
          firstname: "no name",
          lastname: "no lastname",
        );
    tests = await db.getTests(user.id);
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTest(TestModel test) async {
    isLoading = true;
    notifyListeners();
    await DBService().deleteTest(test);
  }
}
