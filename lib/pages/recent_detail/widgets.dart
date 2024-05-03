part of 'imports.dart';

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    final notch = NotchWidget();
    return Consumer<RecentDetailController>(
      builder: (context, RecentDetailController controller, _) {
        return SliverList(
          delegate: SliverChildListDelegate([
            CupertinoListSection.insetGrouped(
              children: <CupertinoListTile>[
                notch.build(
                  title: "Share the results",
                  onTap: controller.share,
                  leading: CupertinoIcons.share,
                ),
              ],
            ),
          ]),
        );
      },
    );
  }
}

class _List extends StatelessWidget {
  final RecentDetailController controller;

  const _List({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        CupertinoListSection.insetGrouped(
          children: List<CupertinoListTile>.generate(
            controller.applicants.length,
            (index) {
              final app = controller.applicants[index];
              return CupertinoListTile.notched(
                leading: Text(
                  "${index + 1}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 15,
                  top: 10,
                  bottom: 10,
                ),
                title: Text(
                  '${app.name} ${app.lastname}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(controller.formatTime(app.time)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      app.corrects.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.systemGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "/${app.totalAttempts}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
