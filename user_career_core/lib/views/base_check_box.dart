import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

enum CheckBoxStyle {
  roundedSquare,
  circle;
}

const _checkBoxSize = 24.0;

class BaseCheckBox extends ConsumerStatefulWidget {
  final bool isSelected;
  final Widget? rightWidget;
  final Function(bool isSelected)? onTap;
  final CheckBoxStyle checkBoxStyle;
  final bool _isOutsideState;

  const BaseCheckBox.initState({
    super.key,
    required this.isSelected,
    this.onTap,
    this.rightWidget,
    this.checkBoxStyle = CheckBoxStyle.roundedSquare,
  }) : _isOutsideState = true;

  const BaseCheckBox({
    super.key,
    this.isSelected = false,
    this.onTap,
    this.rightWidget,
    this.checkBoxStyle = CheckBoxStyle.roundedSquare,
  }) : _isOutsideState = false;

  @override
  ConsumerState createState() => _BaseCheckBoxState();
}

class _BaseCheckBoxState extends ConsumerState<BaseCheckBox> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget._isOutsideState) {
          setState(() {
            _isSelected = !_isSelected;
          });
        }
        widget.onTap
            ?.call(widget._isOutsideState ? widget.isSelected : _isSelected);
      },
      child: _CheckBox(
        isSelected: widget._isOutsideState ? widget.isSelected : _isSelected,
        rightWidget: widget.rightWidget,
        checkBoxStyle: widget.checkBoxStyle,
      ),
    ).height(_checkBoxSize);
  }
}

class _CheckBox extends StatelessWidget {
  final bool isSelected;
  final Widget? rightWidget;
  final CheckBoxStyle checkBoxStyle;

  const _CheckBox(
      {required this.isSelected,
        this.rightWidget,
        required this.checkBoxStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          width: _checkBoxSize,
          height: _checkBoxSize,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: isSelected ? AppColors.mainColor : Colors.transparent,
              border: Border.all(
                  width: 1.0,
                  color: isSelected ? AppColors.mainColor : AppColors.black2Color),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isNormal ? BorderRadius.circular(5) : null),
          duration: kThemeAnimationDuration,
          child: AnimatedScale(
              scale: isSelected ? 1.0 : 0,
              duration: kThemeAnimationDuration,
              child: Assets.icons.icCheckBox.svg()),
        ),
        if (rightWidget != null) ...[
          const Gap(8),
          Material(
            color: Colors.transparent,
            child: rightWidget!,
          )
        ],
      ],
    );
  }

  bool get isCircle => checkBoxStyle == CheckBoxStyle.circle;

  bool get isNormal => checkBoxStyle == CheckBoxStyle.roundedSquare;
}
