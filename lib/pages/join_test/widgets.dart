part of 'imports.dart';

class _JoinButton extends StatelessWidget {
  final bool isLoading;

  const _JoinButton(this.isLoading);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: CupertinoButton(
        color: const Color(0xff6486ff),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : const Text("Join the test"),
        onPressed: () {},
      ),
    );
  }
}
