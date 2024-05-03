part of 'imports.dart';

class MyRecentsPage extends StatefulWidget {
  final UserModel user;

  const MyRecentsPage({
    super.key,
    required this.user,
  });

  @override
  State<MyRecentsPage> createState() => _MyRecentsPageState();
}

class _MyRecentsPageState extends State<MyRecentsPage> {
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
    if (_isConnected) {
      return ChangeNotifierProvider<MyRecentsController>(
        create: (_) => MyRecentsController(widget.user),
        child: Consumer<MyRecentsController>(
          builder: (context, MyRecentsController controller, _) {
            return CupertinoPageScaffold(
              child: CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    backgroundColor:
                        CupertinoTheme.of(context).scaffoldBackgroundColor,
                    largeTitle: const Text('Recent Results'),
                    border: null,
                    stretch: true,
                  ),
                  controller.isLoading
                      ? const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                        )
                      : controller.applicants.isNotEmpty
                          ? _List(controller: controller)
                          : SliverToBoxAdapter(
                              child: Center(
                                child: Lottie.asset("assets/lottie/empty.json"),
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return const NoConnectionPage();
    }
  }
}
