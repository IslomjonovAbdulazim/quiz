import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/connection.json"),
            const Text("No internet connection"),
          ],
        ),
      ),
    );
  }
}
