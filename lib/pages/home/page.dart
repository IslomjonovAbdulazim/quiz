part of 'imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        ? ChangeNotifierProvider<HomeController>(
            create: (_) => HomeController(),
            child: Consumer<HomeController>(
              builder: (context, HomeController controller, _) {
                return CupertinoPageScaffold(
                  child: controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : CustomScrollView(
                          slivers: [
                            CupertinoSliverNavigationBar(
                              backgroundColor: CupertinoTheme.of(context)
                                  .scaffoldBackgroundColor,
                              largeTitle: const Text('The Test'),
                              border: null,
                              stretch: true,
                            ),
                            const _Actions(),
                            const _Tests(),
                          ],
                        ),
                );
              },
            ),
          )
        : const NoConnectionPage();
  }
}
