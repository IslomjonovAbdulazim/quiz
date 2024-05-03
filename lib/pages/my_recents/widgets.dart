part of 'imports.dart';

class _List extends StatelessWidget {
  final MyRecentsController controller;

  const _List({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        CupertinoListSection.insetGrouped(
          children: controller.applicants.map<CupertinoListTile>(
            (app) {
              return CupertinoListTile.notched(
                title: Text(
                  app.title,
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
          ).toList(),
        ),
      ]),
    );
  }
}
