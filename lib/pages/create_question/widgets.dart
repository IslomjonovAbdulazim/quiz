part of 'imports.dart';

class _Divider extends StatelessWidget {
  final String title;

  const _Divider(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: const Color(0xff6486ff).withOpacity(.5),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xff6486ff),
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Divider(
            color: const Color(0xff6486ff).withOpacity(.5),
          ),
        ),
      ],
    );
  }
}

class _QuestionField extends StatelessWidget {
  const _QuestionField();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateQuestionController>(
      builder: (context, CreateQuestionController controller, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
          child: CupertinoTextField(
            focusNode: controller.questionFocus,
            textCapitalization: TextCapitalization.sentences,
            placeholder: 'Question',
            textInputAction: TextInputAction.next,
            controller: controller.questionController,
            autofocus: true,
            style: const TextStyle(fontSize: 15),
            onTapOutside: (PointerDownEvent a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            autocorrect: false,
            onSubmitted: (a) {
              FocusScope.of(context).requestFocus(controller.answerFocus);
            },
            clearButtonMode: OverlayVisibilityMode.editing,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            maxLength: 200,
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

class _AnswerField extends StatelessWidget {
  const _AnswerField();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateQuestionController>(
      builder: (context, CreateQuestionController controller, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
          child: CupertinoTextField(
            textCapitalization: TextCapitalization.sentences,
            placeholder: 'Answer',
            focusNode: controller.answerFocus,
            textInputAction: TextInputAction.next,
            controller: controller.answerController,
            style: const TextStyle(fontSize: 15),
            onTapOutside: (PointerDownEvent a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            autocorrect: false,
            onSubmitted: (a) {
              FocusScope.of(context).requestFocus(controller.variantOneFocus);
            },
            clearButtonMode: OverlayVisibilityMode.editing,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            maxLength: 500,
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

class _VariantOneField extends StatelessWidget {
  const _VariantOneField();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateQuestionController>(
      builder: (context, CreateQuestionController controller, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: CupertinoTextField(
            textCapitalization: TextCapitalization.sentences,
            placeholder: 'Variant one',
            focusNode: controller.variantOneFocus,
            textInputAction: TextInputAction.next,
            controller: controller.variantOneController,
            style: const TextStyle(fontSize: 15),
            onTapOutside: (PointerDownEvent a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            autocorrect: false,
            onSubmitted: (a) {
              FocusScope.of(context).requestFocus(controller.variantTwoFocus);
            },
            clearButtonMode: OverlayVisibilityMode.editing,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            maxLength: 500,
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

class _VariantTwoField extends StatelessWidget {
  const _VariantTwoField();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateQuestionController>(
      builder: (context, CreateQuestionController controller, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: CupertinoTextField(
            textCapitalization: TextCapitalization.sentences,
            placeholder: 'Variant two',
            focusNode: controller.variantTwoFocus,
            textInputAction: TextInputAction.next,
            controller: controller.variantTwoController,
            style: const TextStyle(fontSize: 15),
            onTapOutside: (PointerDownEvent a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            autocorrect: false,
            onSubmitted: (a) {
              FocusScope.of(context).requestFocus(controller.variantThreeFocus);
            },
            clearButtonMode: OverlayVisibilityMode.editing,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            maxLength: 500,
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

class _VariantThreeField extends StatelessWidget {
  const _VariantThreeField();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateQuestionController>(
      builder: (context, CreateQuestionController controller, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: CupertinoTextField(
            textCapitalization: TextCapitalization.sentences,
            placeholder: 'Variant three',
            focusNode: controller.variantThreeFocus,
            textInputAction: TextInputAction.done,
            controller: controller.variantThreeController,
            style: const TextStyle(fontSize: 15),
            onTapOutside: (PointerDownEvent a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            autocorrect: false,
            onSubmitted: (a) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            clearButtonMode: OverlayVisibilityMode.editing,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            maxLength: 500,
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
