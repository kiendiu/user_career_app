import 'package:flutter/material.dart';

class CustomTextFieldView extends StatefulWidget {
  final String? initialText;
  final ValueChanged<String?>? textFieldDidChange;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final InputDecoration decoration;
  final Widget? suffixIcon;
  final TextEditingController? textEditingController;

  const CustomTextFieldView({
    super.key,
    this.initialText,
    this.textFieldDidChange,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.suffixIcon,
    this.textEditingController,
    required this.decoration,
  });

  @override
  _CustomTextFieldViewState createState() => _CustomTextFieldViewState();
}

class _CustomTextFieldViewState extends State<CustomTextFieldView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void didUpdateWidget(covariant CustomTextFieldView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialText != oldWidget.initialText) {
      _controller.text = widget.initialText ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      decoration: widget.decoration.copyWith(
        suffixIcon: widget.suffixIcon,
      ),
      onChanged: widget.textFieldDidChange,
    );
  }
}