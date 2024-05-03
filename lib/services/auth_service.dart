import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_quiz/models/user_model.dart';
import 'package:the_quiz/pages/login/imports.dart';

class AuthService {
  static Stream<User?> get authStateChanges {
    return FirebaseAuth.instance.authStateChanges();
  }

  static String? get userId {
    return FirebaseAuth.instance.currentUser?.email!.split("@").first;
  }

  static Future<void> sign(BuildContext context) async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    late String uuid;
    if (Platform.isAndroid) {
      uuid = (await deviceInfoPlugin.androidInfo).id;
    } else if (Platform.isIOS) {
      uuid = (await deviceInfoPlugin.iosInfo).identifierForVendor!;
    }
    final res = await signIn(uuid);
    if (!res) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    }
  }

  static Future<bool> signIn(String uuid) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
        email: "$uuid@azim.com",
        password: "PPd£&%XvADH8!@A@",
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> createAccount(String uuid) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
        email: "$uuid@azim.com",
        password: "PPd£&%XvADH8!@A@",
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> logOut() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
