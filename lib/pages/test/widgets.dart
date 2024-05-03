part of 'imports.dart';

class _Result extends StatelessWidget {
  final ApplicantModel applicant;

  const _Result({required this.applicant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox.shrink(),
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                color: CupertinoColors.white,
                shape: BoxShape.circle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    applicant.corrects.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      color: CupertinoColors.systemGreen,
                    ),
                  ),
                  Text(
                    "/${applicant.totalAttempts}",
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: CupertinoButton(
                color: CupertinoColors.systemGreen,
                child: const Text("Back to home"),
                onPressed: () {
                  HapticFeedback.selectionClick();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Variants extends StatelessWidget {
  const _Variants();

  @override
  Widget build(BuildContext context) {
    return Consumer<TestController>(
        builder: (context, TestController controller, _) {
      return controller.isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Column(
              children: controller.getCurrentVariants.map(
                (variant) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: controller.result == null
                          ? () {
                              controller.select(variant);
                            }
                          : null,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            variant,
                            style: TextStyle(
                              fontSize: 13,
                              color: controller.getColor(variant),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
    });
  }
}
