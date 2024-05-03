part of 'imports.dart';

class DetailTestPage extends StatefulWidget {
  final TestModel test;

  const DetailTestPage({super.key, required this.test});

  @override
  State<DetailTestPage> createState() => _DetailTestPageState();
}

class _DetailTestPageState extends State<DetailTestPage> {
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
        ? ChangeNotifierProvider<DetailTestController>(
            create: (_) => DetailTestController(widget.test),
            child: Consumer<DetailTestController>(
              builder: (context, DetailTestController controller, _) {
                return controller.test.onLive != null
                    ? CupertinoPageScaffold(
                        child: SafeArea(
                          child: CustomScrollView(
                            slivers: [
                              CupertinoSliverNavigationBar(
                                backgroundColor: CupertinoTheme.of(context)
                                    .scaffoldBackgroundColor,
                                largeTitle: _LiveCode(controller.test.onLive!),
                                border: null,
                                stretch: true,
                              ),
                              _FinishButton(
                                controller.finishTheTest,
                                controller.live,
                              ),
                              _Stream(controller: controller),
                            ],
                          ),
                        ),
                      )
                    : CupertinoPageScaffold(
                        child: CustomScrollView(
                          slivers: [
                            CupertinoSliverNavigationBar(
                              backgroundColor: CupertinoTheme.of(context)
                                  .scaffoldBackgroundColor,
                              largeTitle: const Text('Detailed test'),
                              border: null,
                              stretch: true,
                            ),
                            const _Actions(),
                            const _Questions(),
                          ],
                        ),
                      );
              },
            ),
          )
        : const NoConnectionPage();
  }
}
