import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

import 'base_search_bar_view.dart';

const _appBarHeight = 54.0;

class AppBarActionButton {
  Widget child;
  Function? onTap;

  AppBarActionButton({required this.child, this.onTap});
}

class BaseAppBarView extends StatefulWidget implements PreferredSizeWidget {
  final bool shouldShowLeading;

  // show back button or exit button
  final bool shouldShowBackButton;
  final String title;
  final List<AppBarActionButton> actions;
  final BaseAppBarController? controller;
  final Function(String)? onSearchTextChanged;
  final Function? onTapBackButton;

  const BaseAppBarView(
      {super.key,
        this.shouldShowLeading = true,
        this.shouldShowBackButton = true,
        required this.title,
        this.actions = const [],
        this.controller,
        this.onSearchTextChanged,
        this.onTapBackButton})
      : assert(actions.length <= 3); // max actions = 2

  @override
  State<BaseAppBarView> createState() => _BaseAppBarViewState();

  @override
  Size get preferredSize => const Size.fromHeight(_appBarHeight);
}

class _BaseAppBarViewState extends State<BaseAppBarView>
    with GlobalThemePlugin {
  late final BaseAppBarController _controller;
  late final FocusNode _focusNode = FocusNode();
  late final Debouncer _debouncer = Debouncer.miliseconds(
    value: 500,
    onValue: (value) {
      widget.onSearchTextChanged?.call(value ?? '');
    },
  );

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? BaseAppBarController();

    _controller.addListener(
          () {
        if (_controller._shouldShowAppBar) {
          _focusNode.unfocus();
        } else {
          _focusNode.requestFocus();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: _controller,
        builder: (_, __) => AnimatedCrossFade(
            excludeBottomFocus: false,
            duration: kThemeAnimationDuration,
            // first child and second child height must equal or else weird animation
            firstChild: _appBar
                .align(Alignment.center)
                .marginOnly(left: widget.shouldShowLeading ? null : 16)
                .height(_appBarHeight),
            secondChild: _searchBar
                .height(40)
                .align(Alignment.center)
                .marginOnly(left: 16)
                .height(_appBarHeight),
            crossFadeState: _controller._shouldShowAppBar
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond)
            .align(Alignment.bottomCenter)
            .paddingOnly(right: 10)
        // .defaultHorizontalPadding(value: 16)
            .makeColor(AppColors.mainColor));
  }

  Widget get _searchBar => BaseSearchBarView(
      focusNode: _focusNode,
      placeholder: "Tìm kiếm",
      onTapCancelButton: () {
        _controller.changeAppBarState(true);
        if (_debouncer.value != '') _debouncer.value = '';
      },
      onSearchTextChanged: (text) => _debouncer.value = text);

  Widget get _appBar =>
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildBackButton,
        _buildTitle.expand(),
        if (widget.actions.isNotEmpty) const Gap(20),
        _buildActions
      ]);

  Widget get _buildBackButton => switch (widget.shouldShowLeading) {
    true => CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if (widget.onTapBackButton.isNotNull) {
          widget.onTapBackButton?.call();
          return;
        }

        context.maybePop();
      },
      child: Visibility(
          visible: widget.shouldShowBackButton,
          replacement: Assets.icons.icAppBarExit.svg().center(),
          child: Assets.icons.icAppBarBack.svg().center()),
    ),
    false => const SizedBox.shrink()
  };

  Widget get _buildTitle => Text(
    widget.title,
    style: const TextStyle()
        .textColor(AppColors.white1Color)
        .size(18)
        .weight(FontWeight.w500),
    overflow: TextOverflow.ellipsis,
  );

  Widget get _buildActions => Row(
    children: widget.actions
        .map((element) => CupertinoButton(
      padding: EdgeInsets.zero,
      disabledColor: Colors.transparent,
      pressedOpacity: 0.6,
      onPressed:
      element.onTap != null ? () => element.onTap!() : null,
      child: element.child.center(),
    ))
        .toList(),
  );
}

class BaseAppBarController with ChangeNotifier {
  var _shouldShowAppBar = true;

  void changeAppBarState(bool showAppBar) {
    _shouldShowAppBar = showAppBar;
    notifyListeners();
  }
}
