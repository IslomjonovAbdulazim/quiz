part of 'imports.dart';

class JoinTestPage extends StatefulWidget {
  final UserModel user;

  const JoinTestPage({super.key, required this.user});

  @override
  State<JoinTestPage> createState() => _JoinTestPageState();
}

class _JoinTestPageState extends State<JoinTestPage> {
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
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return _isConnected
        ? ChangeNotifierProvider<JoinTestController>(
            create: (_) => JoinTestController(widget.user),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: CupertinoNavigationBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.chevron_left,
                    size: 22,
                  ),
                ),
                middle: const Text("Joining a test"),
              ),
              body: Center(
                child: Consumer<JoinTestController>(
                  builder: (context, JoinTestController controller, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: Material(
                            child: Pinput(
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              controller: controller.controller,
                              errorText: controller.problem,
                              autofocus: true,
                              validator: (s) {
                                return controller.problem;
                              },
                              errorBuilder: (_, __) {
                                return controller.problem != null
                                    ? Text(
                                        controller.problem!,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: CupertinoColors.systemRed,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    : const SizedBox.shrink();
                              },
                              showCursor: false,
                              onCompleted: (pin) async {
                                await controller.joinTest(context);
                              },
                              forceErrorState: controller.problem != null,
                              onChanged: (a) {
                                controller.problem = null;
                                controller.notifyListeners();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _JoinButton(controller.isLoading),
                        const SizedBox(height: 250),
                      ],
                    );
                  },
                ),
              ),
            ),
          )
        : const NoConnectionPage();
  }
}
