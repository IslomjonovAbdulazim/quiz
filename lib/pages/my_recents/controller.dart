part of 'imports.dart';

class MyRecentsController extends ChangeNotifier {
  List<ApplicantModel> applicants = [];
  final UserModel user;
  bool isLoading = false;

  MyRecentsController(this.user) {
    init();
  }

  String formatTime(DateTime t) {
    String date = DateFormat.yMMMd().format(t);
    String time = DateFormat.Hm().format(t);
    return "📅$date  ⏰$time";
  }

  void init() async {
    isLoading = true;
    notifyListeners();
    applicants = await TestDBService().applicants(user);
    isLoading = false;
    notifyListeners();
  }
}