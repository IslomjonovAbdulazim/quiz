part of 'imports.dart';

class _Field extends StatelessWidget {
  const _Field();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateTestController>(
      builder: (context, CreateTestController controller, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CupertinoTextField(
            textCapitalization: TextCapitalization.words,
            placeholder: 'Title for a test',
            textInputAction: TextInputAction.done,
            controller: controller.titleController,
            autofocus: true,
            onTapOutside: (PointerDownEvent a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            autocorrect: false,
            clearButtonMode: OverlayVisibilityMode.editing,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            maxLength: 100,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}


