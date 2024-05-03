part of 'imports.dart';

class TestPage extends StatefulWidget {
  final String liveCode;
  final UserModel user;

  const TestPage({super.key, required this.liveCode, required this.user});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
        ? ChangeNotifierProvider<TestController>(
            create: (_) => TestController(widget.liveCode, widget.user),
            child: Consumer<TestController>(
              builder: (context, controller, _) {
                return PopScope(
                  canPop: false,
                  child: CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      leading: const SizedBox.shrink(),
                      trailing: controller.getShowResult
                          ? null
                          : Text(
                              "${controller.currentQuestion + 1}/${controller.questions.length}",
                            ),
                    ),
                    child: controller.getShowResult
                        ? _Result(applicant: controller.applicant)
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 10,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: controller.isLoading
                                        ? const CircularProgressIndicator
                                            .adaptive()
                                        : Text(
                                            controller.getCurrentQuestion,
                                            style: const TextStyle(
                                              color: CupertinoColors.black,
                                            ),
                                          ),
                                  ),
                                ),
                                const Expanded(
                                  child: _Variants(),
                                ),
                                const SizedBox(height: 10),
                                CupertinoButton(
                                  color: const Color(0xff6486ff),
                                  onPressed: controller.result != null
                                      ? () {
                                          HapticFeedback.selectionClick();
                                          controller.next(context);
                                        }
                                      : null,
                                  child: controller.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        )
                                      : const Text("Next"),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                  ),
                );
              },
            ),
          )
        : const NoConnectionPage();
  }
}
