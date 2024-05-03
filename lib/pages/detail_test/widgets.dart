part of 'imports.dart';

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    final notch = NotchWidget();
    return Consumer<DetailTestController>(
      builder: (context, DetailTestController controller, _) {
        final isEnough = controller.questions.length > 5;
        return SliverList(
          delegate: SliverChildListDelegate([
            CupertinoListSection.insetGrouped(
              children: <CupertinoListTile>[
                notch.build(
                  title: "Recent results",
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return RecentsPage(test: controller.test);
                        },
                      ),
                    );
                  },
                  leading: CupertinoIcons.star,
                ),
                notch.build(
                  title: isEnough
                      ? "Start a live test"
                      : "At least 6 questions required",
                  onTap: isEnough
                      ? () {
                          controller.startLive();
                        }
                      : () {
                          HapticFeedback.vibrate();
                        },
                  leading: CupertinoIcons.alarm,
                ),
                notch.build(
                  title: "Share questions of the test",
                  onTap: controller.share,
                  leading: CupertinoIcons.share,
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              children: <CupertinoListTile>[
                notch.build(
                  title: "Add a new question",
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return CreateQuestionPage(test: controller.test);
                        },
                      ),
                    ).then((value) {
                      if (value == "update") {
                        controller.init();
                      }
                    });
                  },
                  leading: CupertinoIcons.add,
                ),
                notch.build(
                  title: "Edit this test",
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return CreateTestPage(
                            userId: controller.test.author,
                            test: controller.test,
                          );
                        },
                      ),
                    );
                  },
                  leading: Icons.edit_outlined,
                ),
                notch.build(
                  title: "Delete this test",
                  onTap: () {
                    HapticFeedback.vibrate();
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text("Delete test and all questions"),
                          content: const Text("This action cannot be undone"),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context, 'delete');
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
            ),
          ]),
        );
      },
    );
  }
}

class _Questions extends StatelessWidget {
  const _Questions();

  @override
  Widget build(BuildContext context) {
    final notch = NotchWidget();
    return Consumer<DetailTestController>(
      builder: (context, DetailTestController controller, _) {
        final length = controller.questions.length;
        return controller.isLoading
            ? const SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              )
            : length == 0
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Lottie.asset("assets/lottie/empty.json"),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildListDelegate([
                      CupertinoListSection.insetGrouped(
                        header:
                            Text("$length question${length > 1 ? 's' : ''}"),
                        children: controller.questions.map<CupertinoListTile>(
                          (question) {
                            return notch.build(
                              title: question.question,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                      return DetailQuestionPage(
                                        question: question,
                                        test: controller.test,
                                      );
                                    },
                                  ),
                                ).then((value) {
                                  controller.init();
                                });
                              },
                              trailing: CupertinoIcons.chevron_right,
                              leading: CupertinoIcons.question_circle,
                            );
                          },
                        ).toList(),
                      )
                    ]),
                  );
      },
    );
  }
}

class _LiveCode extends StatelessWidget {
  final int code;

  const _LiveCode(this.code);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "code: ",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Text("$code"),
      ],
    );
  }
}

class _FinishButton extends StatelessWidget {
  final VoidCallback finish;
  final LiveModel live;

  const _FinishButton(this.finish, this.live);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: CupertinoButton(
          color: CupertinoColors.systemRed,
          onPressed: () {
            HapticFeedback.vibrate();
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text("Finish the test"),
                  content: const Text("This action cannot be undone"),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      isDestructiveAction: true,
                      onPressed: () async {
                        finish();
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => RecentDetailPage(live: live),
                          ),
                        );
                      },
                      child: const Text('Finish'),
                    ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Continue'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text("Finish the test"),
        ),
      ),
    );
  }
}

class _Stream extends StatelessWidget {
  final DetailTestController controller;

  const _Stream({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StreamBuilder(
        stream: TestDBService().getLiveData(controller.test),
        builder: (
          _,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          final List<ApplicantModel> applicants = snapshot.data!.docs
              .map((app) => ApplicantModel.fromJson(app.data()))
              .toList();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: applicants.map((app) {
                return app.userId != controller.test.author
                    ? Card(
                        child: ListTile(
                          leading: app.avatar == null
                              ? null
                              : Image.network(app.avatar!),
                          title: Text(
                            "${app.name} ${app.lastname}",
                            style: const TextStyle(fontSize: 15),
                          ),
                          trailing: Text(
                            "${app.corrects}/${app.totalAttempts}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
