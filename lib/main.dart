import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_quiz/pages/home/imports.dart';
import 'package:the_quiz/services/auth_service.dart';
import 'package:the_quiz/widgets/no_connection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthService.logOut();
  runApp(const IOSApp());
}

class IOSApp extends StatefulWidget {
  const IOSApp({super.key});

  @override
  State<IOSApp> createState() => _IOSAppState();
}

class _IOSAppState extends State<IOSApp> {
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
    return CupertinoApp(
      theme: const CupertinoThemeData(
        scaffoldBackgroundColor: Color(0xfff1f0f6),
        primaryColor: Color(0xff6486ff),
      ),
      debugShowCheckedModeBanner: false,
      title: 'The Test',
      home: _isConnected
          ? StreamBuilder<User?>(
              stream: AuthService.authStateChanges,
              builder: (context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                } else {
                  if (snapshot.hasData && snapshot.data != null) {
                    print(snapshot.data?.email);
                    return const HomePage();
                  } else {
                    AuthService.sign(context);
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  }
                }
              },
            )
          : const NoConnectionPage(),
    );
  }
}

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
