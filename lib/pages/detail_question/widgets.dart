part of 'imports.dart';

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    final notch = NotchWidget();
    return Consumer<DetailQuestionController>(
      builder: (context, DetailQuestionController controller, _) {
        return SliverList(
          delegate: SliverChildListDelegate([
            CupertinoListSection.insetGrouped(
              children: <CupertinoListTile>[
                notch.build(
                  title: "Share the question",
                  onTap: controller.share,
                  leading: CupertinoIcons.share,
                ),
                notch.build(
                  title: "Edit the question",
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return CreateQuestionPage(
                            question: controller.question,
                            test: controller.test,
                          );
                        },
                      ),
                    ).then((value) {
                      if (value is QuestionModel) {
                        controller.update(value);
                      }
                    });
                  },
                  leading: Icons.edit_outlined,
                ),
                notch.build(
                  title: "Delete the question",
                  onTap: () async {
                    HapticFeedback.vibrate();
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text("Delete this question"),
                          content: const Text("This action cannot be undone"),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              isDestructiveAction: true,
                              onPressed: () async {
                                await controller.delete(context);
                              },
                              child: const Text('Delete'),
                            ),
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  leading: CupertinoIcons.delete,
                ),
              ],
            )
          ]),
        );
      },
    );
  }
}

class _Question extends StatelessWidget {
  const _Question();

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailQuestionController>(
      builder: (context, DetailQuestionController controller, _) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Question",
                  style: TextStyle(
                    fontSize: 12,
                    height: 1,
                    color: Color(0xff6486ff),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    controller.question.question,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Answer",
                  style: TextStyle(
                    fontSize: 12,
                    height: 1,
                    color: Color(0xff6486ff),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    controller.question.answer,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Variants",
                  style: TextStyle(
                    fontSize: 12,
                    height: 1,
                    color: Color(0xff6486ff),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    controller.question.variantOne,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    controller.question.variantTwo,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    controller.question.variantThree,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
