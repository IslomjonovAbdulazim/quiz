part of 'imports.dart';

class RecentDetailController extends ChangeNotifier {
  List<ApplicantModel> applicants = [];
  Map<ApplicantModel, double> sortedApplicants = {};
  bool isLoading = false;
  final LiveModel live;

  RecentDetailController(this.live) {
    init();
  }

  void share() {
    String result = "🌟${live.code}  ${_formatTime(live.start, live.end)}\n\n";
    for (int i = 0; i < applicants.length; i++) {
      final app = applicants[i];
      result +=
          "No. ${i + 1} ︱ 👤${app.name} ${app.lastname} ︱ 🎯${app.corrects}/${app.totalAttempts}\n";
    }
    Share.share(result);
  }

  String _formatTime(DateTime t1, DateTime t2) {
    String date = DateFormat.yMMMd().format(t1);
    String time1 = DateFormat.Hm().format(t1);
    String time2 = DateFormat.Hm().format(t2);
    return "📅$date  ⏰$time1-$time2";
  }

  String formatTime(DateTime t) {
    String date = DateFormat.yMMMd().format(t);
    String time = DateFormat.Hm().format(t);
    return "📅$date  ⏰$time";
  }

  void init() async {
    isLoading = true;
    notifyListeners();
    applicants = await TestDBService().testDetail(live);
    applicants.removeWhere((element) => element.userId == live.author);
    Map<ApplicantModel, double> map2sort = {};
    for (var app in applicants) {
      map2sort[app] = app.corrects / app.totalAttempts;
    }
    List<MapEntry<ApplicantModel, double>> entries = map2sort.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    applicants = entries.map((map) => map.key).toList();
    isLoading = false;
    notifyListeners();
  }
}
