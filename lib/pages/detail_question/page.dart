part of 'imports.dart';

class DetailQuestionPage extends StatefulWidget {
  final QuestionModel question;
  final TestModel test;

  const DetailQuestionPage({
    super.key,
    required this.question,
    required this.test,
  });

  @override
  State<DetailQuestionPage> createState() => _DetailQuestionPageState();
}

class _DetailQuestionPageState extends State<DetailQuestionPage> {
  bool _isConnected = true;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      setState(() {
        _isConnected = results.contains(ConnectivityResult.mobile) ||
            results.contains(ConnectivityResult.wifi);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return _isConnected
        ? ChangeNotifierProvider<DetailQuestionController>(
            create: (_) => DetailQuestionController(
              widget.question,
              widget.test,
            ),
            child: CupertinoPageScaffold(
              child: CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    backgroundColor:
                        CupertinoTheme.of(context).scaffoldBackgroundColor,
                    largeTitle: const Text('Detailed question'),
                    border: null,
                    stretch: true,
                  ),
                  const _Actions(),
                  const _Question(),
                ],
              ),
            ),
          )
        : const NoConnectionPage();
  }
}
