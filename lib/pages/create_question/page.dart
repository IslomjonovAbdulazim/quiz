part of 'imports.dart';

class CreateQuestionPage extends StatefulWidget {
  final TestModel test;
  final QuestionModel? question;

  const CreateQuestionPage({
    super.key,
    this.question,
    required this.test,
  });

  @override
  State<CreateQuestionPage> createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
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
        ? ChangeNotifierProvider<CreateQuestionController>(
            create: (_) => CreateQuestionController(
              widget.test,
              widget.question,
            ),
            child: Builder(builder: (context) {
              final provider = Provider.of<CreateQuestionController>(context);
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  leading: provider.isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                  middle: Text(widget.question == null
                      ? 'Create a new question'
                      : 'Edit the question'),
                  trailing: provider.isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            HapticFeedback.selectionClick();
                            provider.save(context).then((value) {
                              if (value) {
                                Navigator.pop(
                                    context, provider.question ?? "update");
                              }
                            });
                          },
                          child: const Text("Save"),
                        ),
                ),
                child: SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    children: const [
                      _Divider("Question"),
                      _QuestionField(),
                      _Divider("Answer"),
                      _AnswerField(),
                      _Divider("Variants"),
                      _VariantOneField(),
                      _VariantTwoField(),
                      _VariantThreeField(),
                    ],
                  ),
                ),
              );
            }),
          )
        : const NoConnectionPage();
  }
}
