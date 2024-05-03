part of 'imports.dart';

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, LoginController controller, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CupertinoTextField(
            textCapitalization: TextCapitalization.words,
            placeholder: 'Your firstname',
            textInputAction: TextInputAction.next,
            controller: controller.firstnameController,
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
            onSubmitted: (a) {
              FocusScope.of(context).requestFocus(controller.lastnameFocus);
            },
            maxLength: 50,
            maxLines: 1,
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

class _LastnameField extends StatelessWidget {
  const _LastnameField();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, LoginController controller, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CupertinoTextField(
            textCapitalization: TextCapitalization.words,
            placeholder: 'Your lastname',
            focusNode: controller.lastnameFocus,
            textInputAction: TextInputAction.done,
            controller: controller.lastnameController,
            autofocus: true,
            onTapOutside: (PointerDownEvent a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onSubmitted: (a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            autocorrect: false,
            clearButtonMode: OverlayVisibilityMode.editing,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            maxLength: 50,
            maxLines: 1,
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

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, LoginController controller, _) {
        return CupertinoButton(
          color: const Color(0xff6486ff),
          onPressed: controller.isLoading
              ? null
              : () {
                  controller.onSubmitted(context);
                },
          child: controller.isLoading
              ? const CircularProgressIndicator.adaptive()
              : const Text("Submit"),
        );
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, LoginController controller, _) {
        return GestureDetector(
          onTap: () {
            showActionSheet(
              context,
              controller.pickImage,
              controller.getImageFromCamera,
            );
          },
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              shape: BoxShape.circle,
              image: controller.avatar == null
                  ? null
                  : DecorationImage(
                      image: FileImage(
                        File(controller.avatar!),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
            child: controller.avatar != null
                ? null
                : const Center(
                    child: Icon(
                      CupertinoIcons.profile_circled,
                      size: 60,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

void showActionSheet(
  BuildContext context,
  VoidCallback pickImage,
  VoidCallback takeSelfie,
) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () {
            takeSelfie();
            Navigator.pop(context);
          },
          child: const Text('📷Take a selfie'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            pickImage();
            Navigator.pop(context);
          },
          child: const Text('🖼Select image from gallery'),
        ),
      ],
      cancelButton: CupertinoButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
