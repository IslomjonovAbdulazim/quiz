part of 'imports.dart';

class JoinTestController extends ChangeNotifier {
  String? problem;
  TextEditingController controller = TextEditingController();
  final UserModel user;
  bool isLoading = false;

  JoinTestController(this.user);

  Future<void> joinTest(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    TestDBService database = TestDBService();
    final res = await database.joinLive(user, controller.text);
    if (!res) {
      problem = "code wrong or server problem";
    } else {
      problem = null;
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => TestPage(liveCode: controller.text, user: user),
        ),
      );
    }
    isLoading = false;
    notifyListeners();
  }
}
