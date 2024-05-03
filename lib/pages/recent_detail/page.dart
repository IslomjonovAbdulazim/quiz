part of 'imports.dart';

class RecentDetailPage extends StatefulWidget {
  final LiveModel live;

  const RecentDetailPage({super.key, required this.live});

  @override
  State<RecentDetailPage> createState() => _RecentDetailPageState();
}

class _RecentDetailPageState extends State<RecentDetailPage> {
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
      return ChangeNotifierProvider<RecentDetailController>(
        create: (_) => RecentDetailController(widget.live),
        child: Consumer<RecentDetailController>(
          builder: (context, RecentDetailController controller, _) {
            return CupertinoPageScaffold(
              child: CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    backgroundColor:
                        CupertinoTheme.of(context).scaffoldBackgroundColor,
                    largeTitle: const Text('Detail result'),
                    border: null,
                    stretch: true,
                  ),
                  const _Actions(),
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
