part of 'imports.dart';

class RecentsController extends ChangeNotifier {
  bool isLoading = false;
  final TestModel test;
  List<LiveModel> lives = [];

  RecentsController(this.test) {
    init();
  }

  String formatTime(DateTime t1, DateTime t2) {
    String date = DateFormat.yMMMd().format(t1);
    String time1 = DateFormat.Hm().format(t1);
    String time2 = DateFormat.Hm().format(t2);
    return "📅$date  ⏰$time1-$time2";
  }

  void init() async {
    isLoading = true;
    notifyListeners();
    lives = await TestDBService().lives(test);
    isLoading = false;
    notifyListeners();
  }
}
