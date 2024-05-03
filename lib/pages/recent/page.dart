part of 'imports.dart';

class RecentsPage extends StatefulWidget {
  final TestModel test;

  const RecentsPage({super.key, required this.test});

  @override
  State<RecentsPage> createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {
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
        ? ChangeNotifierProvider<RecentsController>(
            create: (_) => RecentsController(widget.test),
            child: Consumer<RecentsController>(
              builder: (context, RecentsController controller, _) {
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
                              largeTitle: const Text('Recent results'),
                              border: null,
                              stretch: true,
                            ),
                            controller.lives.isNotEmpty
                                ? SliverList(
                                    delegate: SliverChildListDelegate([
                                      CupertinoListSection.insetGrouped(
                                        children: controller.lives
                                            .map<CupertinoListTile>(
                                          (live) {
                                            return CupertinoListTile.notched(
                                              title: Text(
                                                live.code.toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              subtitle: Text(
                                                controller.formatTime(
                                                    live.start, live.end),
                                              ),
                                              trailing: const Icon(
                                                CupertinoIcons.chevron_right,
                                                size: 20,
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (_) =>
                                                        RecentDetailPage(
                                                      live: live,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ]),
                                  )
                                : SliverToBoxAdapter(
                                    child: Center(
                                      child: Lottie.asset(
                                        "assets/lottie/empty.json",
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                );
              },
            ),
          )
        : const NoConnectionPage();
  }
}
