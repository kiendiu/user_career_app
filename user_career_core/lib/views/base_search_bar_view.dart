import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

class BaseSearchBarView extends ConsumerStatefulWidget {
  final String? placeholder;
  final Function()? onTapCancelButton;
  final Function(String? text)? onSearchTextChanged;
  final FocusNode? focusNode;
  // final ValueNotifier<bool> editingState;
  final TextEditingController? textEditingController;
  final Color background;
  final bool shouldShowCancelButton;

  @override
  ConsumerState createState() => _BaseSearchBarState();

  const BaseSearchBarView(
      {super.key,
        this.placeholder,
        this.onTapCancelButton,
        this.onSearchTextChanged,
        // required this.editingState,
        this.textEditingController,
        this.focusNode,
        this.background = Colors.white,
        this.shouldShowCancelButton = true});
}

class _BaseSearchBarState extends ConsumerState<BaseSearchBarView> {
  bool _isEditingCompleted = false;
  late FocusNode _focusNode;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _textController = widget.textEditingController ?? TextEditingController();

    // widget.editingState.addListener(() {
    //   isEditingCompleted = widget.editingState.value;
    //
    //   if (isEditingCompleted) {
    //     widget.focusNode?.unfocus();
    //   }
    // });
  }

  // @override
  // void didUpdateWidget(covariant BaseSearchBar oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (isEditingCompleted) {
  //     return;
  //   }
  //   // widget.focusNode?.requestFocus();
  // }

  @override
  void dispose() {
    _focusNode.unfocus();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          decoration: ShapeDecoration(
            color: widget.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(12),
              Assets.icons.icSearch.svg(
                width: 20,
                height: 20,
                color: AppColors.black3Color,
              ),
              CupertinoTextField.borderless(
                controller: _textController,
                focusNode: _focusNode,
                onChanged: widget.onSearchTextChanged,
                // style: AppStyle.base14Regular,
                style: ref.theme.mediumTextStyle,
                placeholder:
                widget.placeholder ?? 'Tìm kiếm',
                onTapOutside: (_) {
                  _focusNode.unfocus();
                },
                clearButtonMode: OverlayVisibilityMode.editing,
                onEditingComplete: () {
                  _isEditingCompleted = true;
                  widget.focusNode?.unfocus();
                },
              ).flexible(),
              const Gap(6),
            ],
          ),
        ).flexible(),
        if (widget.shouldShowCancelButton) const Gap(4),
        if (widget.shouldShowCancelButton)
          CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                _textController.clear();
                widget.onTapCancelButton?.call();
              },
              child: Text(
                'Hủy',
                style: ref.theme
                    .mediumTextStyle
                    .copyWith(color: AppColors.white1Color),
              )),
      ],
    );
  }
}
