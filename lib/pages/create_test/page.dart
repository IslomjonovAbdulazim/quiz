part of 'imports.dart';

class CreateTestPage extends StatefulWidget {
  final String userId;
  final TestModel? test;

  const CreateTestPage({super.key, required this.userId, this.test});

  @override
  State<CreateTestPage> createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage> {
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
        ? ChangeNotifierProvider<CreateTestController>(
            create: (_) => CreateTestController(widget.userId, widget.test),
            child: Builder(builder: (context) {
              final provider = Provider.of<CreateTestController>(context);
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
                  middle: Text(widget.test == null
                      ? 'Create a new test'
                      : 'Edit the test'),
                  trailing: provider.isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            HapticFeedback.selectionClick();
                            provider.save(context).then((value) {
                              if (value) {
                                Navigator.pop(context, "update");
                              }
                            });
                          },
                          child: const Text("Save"),
                        ),
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    SizedBox(height: 20),
                    _Field(),
                  ],
                ),
              );
            }),
          )
        : const NoConnectionPage();
  }
}
