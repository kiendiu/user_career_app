import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

class CustomExpansionTile extends StatefulWidget {
  final EdgeInsetsGeometry childrenPadding;
  final Widget title;
  final Border shape;
  final Widget? trailing;
  final List<Widget> children;
  final Function(bool)? onExpansionChanged;

  const CustomExpansionTile({super.key,
    required this.childrenPadding,
    required this.title,
    required this.shape,
    this.trailing,
    required this.children,
    this.onExpansionChanged,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white1Color,
      ),
      child: ExpansionTile(
        childrenPadding: widget.childrenPadding,
        title: widget.title,
        shape: widget.shape,
        controlAffinity: ListTileControlAffinity.leading,
        leading:  AnimatedRotation(
          turns: _isExpanded ? 0.25 : 0,
          duration: const Duration(milliseconds: 250),
          child: Assets.icons.icAngleSmallRight.svg(
            colorFilter: const ColorFilter.mode(
              AppColors.black1Color,
              BlendMode.srcIn,
            )
          ),
        ),
        trailing: widget.trailing,
        onExpansionChanged: _handleExpansion,
        children: widget.children,
      ),
    );
  }

  void _handleExpansion(bool expanded) {
    setState(() {
      _isExpanded = expanded;
    });

    widget.onExpansionChanged?.call(expanded);
  }
}