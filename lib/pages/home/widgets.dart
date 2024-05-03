part of 'imports.dart';

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    final notch = NotchWidget();
    return Consumer<HomeController>(
      builder: (context, HomeController controller, _) {
        return SliverList(
          delegate: SliverChildListDelegate([
            CupertinoListSection.insetGrouped(
              children: <CupertinoListTile>[
                notch.build(
                  title: "My recent results",
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => MyRecentsPage(user: controller.user),
                      ),
                    );
                  },
                  leading: CupertinoIcons.star,
                ),
                notch.build(
                  title: "Join a test",
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => JoinTestPage(user: controller.user),
                      ),
                    );
                  },
                  leading: CupertinoIcons.search,
                ),
                notch.build(
                  title: "Create a new test",
                  onTap: () async {
                    HapticFeedback.selectionClick();
                    final res = await Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return CreateTestPage(
                            userId: controller.user.id,
                          );
                        },
                      ),
                    );
                    if (res == "update") {
                      controller.init();
                    }
                  },
                  leading: CupertinoIcons.add,
                ),
              ],
            ),
          ]),
        );
      },
    );
  }
}

class _Tests extends StatelessWidget {
  const _Tests();

  @override
  Widget build(BuildContext context) {
    final notch = NotchWidget();
    return Consumer<HomeController>(
      builder: (context, HomeController controller, _) {
        return controller.tests.isNotEmpty
            ? SliverList(
                delegate: SliverChildListDelegate([
                  CupertinoListSection.insetGrouped(
                    header: const Text("Your tests"),
                    children: controller.tests.map<CupertinoListTile>(
                      (test) {
                        return notch.build(
                          title: test.title,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (BuildContext context) {
                                  return DetailTestPage(test: test);
                                },
                              ),
                            ).then((value) async {
                              if (value == "delete") {
                                await controller.deleteTest(test);
                              }
                              controller.init();
                            });
                          },
                          trailing: CupertinoIcons.chevron_right,
                          leading: CupertinoIcons.doc,
                        );
                      },
                    ).toList(),
                  ),
                ]),
              )
            : SliverToBoxAdapter(
                child: Center(
                  child: Lottie.asset("assets/lottie/empty.json"),
                ),
              );
      },
    );
  }
}
