part of 'imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        ? ChangeNotifierProvider<LoginController>(
            create: (_) => LoginController(),
            child: const CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Avatar(),
                  SizedBox(height: 20),
                  _NameField(),
                  SizedBox(height: 10),
                  _LastnameField(),
                  SizedBox(height: 10),
                  _Button(),
                  SizedBox(height: 100),
                ],
              ),
            ),
          )
        : const NoConnectionPage();
  }
}
