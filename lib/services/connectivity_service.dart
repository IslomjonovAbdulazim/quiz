// import 'dart:async';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// class ConnectivityService {
//   bool _isConnected = true;
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _connectivitySubscription = Connectivity()
//         .onConnectivityChanged
//         .listen((List<ConnectivityResult> results) {
//       setState(() {
//         _isConnected = results.contains(ConnectivityResult.mobile) ||
//             results.contains(ConnectivityResult.wifi);
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _connectivitySubscription.cancel();
//   }
// }
