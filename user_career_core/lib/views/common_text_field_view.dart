import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:user_career_core/utils/text_field_config.dart';

class CommonTextFieldView extends StatelessWidget with GlobalThemePlugin {
  final bool autoFocus;
  final FocusNode? focusNode;
  final double height;
  final double? borderRadius;
  final bool isExpanded;
  final CharacterLengthLimiter? lengthLimiter;
  final String? title;
  final String? placeholder;
  final String? initialText;
  final TextStyle? titleTextStyle;
  final TextStyle? placeholderTextStyle;
  final bool Function(String?)? validator;
  final List<TextInputFormatter> inputFormatters;
  final bool isSelectable;
  final bool isRequired;
  final bool isDisabled;
  final bool isObscureText;
  final bool containHtml;
  final TextEditingController? textEditingController;
  final Widget? titleWidget;
  final List<Widget> suffixIcons;
  final List<Widget> prefixIcons;
  final dynamic Function(String? text)? textFieldDidChange;
  final String Function()? errorText;
  final TextInputType inputType;
  final void Function()? onTapTextField;
  final bool Function()? enableBy;
  final Color? backgroundColor;
  final List<BoxShadow> shadows;
  final TextAlignVertical? textAlignVertical;
  final dynamic Function(AnimationController)?
  onInitializeErrorBorderAnimationController;
  final dynamic Function(AnimationController)?
  onInitializeFocusedBorderAnimationController;
  final bool Function()? hasTapOnTextFieldWhenSelectable;
  final BoxConstraints? constraints;

  const CommonTextFieldView({
    super.key,
    this.focusNode,
    this.lengthLimiter,
    this.title,
    this.placeholder,
    this.initialText,
    this.validator,
    this.textEditingController,
    this.titleWidget,
    this.textFieldDidChange,
    this.titleTextStyle,
    this.placeholderTextStyle,
    this.errorText,
    this.onTapTextField,
    this.enableBy,
    this.backgroundColor,
    this.textAlignVertical,
    this.onInitializeErrorBorderAnimationController,
    this.onInitializeFocusedBorderAnimationController,
    this.hasTapOnTextFieldWhenSelectable,
    this.isRequired = false,
    this.constraints = const BoxConstraints(maxHeight: 200),
    this.autoFocus = false,
    this.isExpanded = true,
    this.isSelectable = false,
    this.isDisabled = false,
    this.isObscureText = false,
    this.containHtml = false,
    this.inputFormatters = const [],
    this.suffixIcons = const [],
    this.prefixIcons = const [],
    this.shadows = const [],
    this.height = 48,
    this.borderRadius,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldView.outsideBorder(
      title: title,
      placeholder: placeholder ?? "Vui lòng nhập",
      borderRadius: borderRadius,
      initialText: initialText,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      inputFormatters: inputFormatters,
      lengthLimiter: lengthLimiter ??
          TextFieldConfig.normalTextField.characterLengthLimiter,
      textFieldDidChange: (text) => textFieldDidChange?.call(text),
      titleTextStyle: titleTextStyle,
      placeholderTextStyle: placeholderTextStyle,
      autoFocus: autoFocus,
      focusNode: focusNode,
      height: height,
      isExpanded: isExpanded,
      validator: validator,
      isSelectable: isSelectable,
      isRequired: isRequired,
      isDisabled: isDisabled,
      isObscureText: isObscureText,
      containHtml: containHtml,
      textEditingController: textEditingController,
      titleWidget: titleWidget,
      suffixIcons: suffixIcons,
      prefixIcons: prefixIcons,
      errorText: errorText,
      inputType: inputType,
      onTapTextField: onTapTextField,
      enableBy: enableBy,
      backgroundColor: backgroundColor,
      shadows: shadows,
      textAlignVertical: textAlignVertical,
      onInitializeErrorBorderAnimationController:
      onInitializeErrorBorderAnimationController,
      onInitializeFocusedBorderAnimationController:
      onInitializeFocusedBorderAnimationController,
      hasTapOnTextFieldWhenSelectable: hasTapOnTextFieldWhenSelectable,
      constraints: constraints,
    );
  }
}