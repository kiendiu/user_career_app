import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

class BaseTabBarView extends StatefulWidget {
  final List<TabBarViewData> data;
  final Function(int)? onSelectTabBarItem;
  final TabAlignment tabAlignment;
  final BaseTabBarViewNotifier? tabBarNotifier;

  BaseTabBarView({
    super.key,
    required this.data,
    this.onSelectTabBarItem,
    this.tabAlignment = TabAlignment.center,
    this.tabBarNotifier,
  }) {
    final hasIndex = data.any((e) => e.index != null);
    final numberOfTabHasIndex = data.where((e) => e.index != null).length;
    final numberOfTab = data.length;

    assert(!hasIndex || (hasIndex && numberOfTabHasIndex == numberOfTab),
    'If you want to use index for tab, you have to provide index for all tabs');
  }

  @override
  State<BaseTabBarView> createState() => _BaseTabBarViewState();
}

class _BaseTabBarViewState extends State<BaseTabBarView>
    with TickerProviderStateMixin, GlobalThemePlugin {
  late TabController _tabController;
  var _selectedCurrentTabBarIndex = 0;
  List<TabBarViewData> get _visibleTabs => widget.data.where((e) => e.index?.visible ?? true).toList();

  @override
  void initState() {
    super.initState();
    _initTabController();
    _initTabBarNotifierListener();
  }

  void _initTabController() {
    _tabController = TabController(
        length: _visibleTabs.length,
        vsync: this,
        animationDuration: const Duration(milliseconds: 250));

    _tabController.addListener(() {
      _selectedCurrentTabBarIndex = _tabController.index;
      widget.onSelectTabBarItem?.call(_selectedCurrentTabBarIndex);
    });
  }

  void _initTabBarNotifierListener() {
    widget.tabBarNotifier?._tabBarIndexChangedNotifier.stream.listen((index) {
      final tab = _visibleTabs.firstWhereOrNull((element) => element.index == index);

      if (tab.isNotNull) {
        final index = _visibleTabs.indexOf(tab!);
        _tabController.animateTo(index);
        tab._key.currentState?.setState(() {});
      }
    });

    widget.tabBarNotifier?._tabBarVisibilityChangedNotifier.stream.listen((_) {
      _tabController.dispose();
      _initTabController();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    widget.tabBarNotifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelPadding: _labelPadding,
            // labelStyle: _labelTextStyle,
            // unselectedLabelStyle: _unselectedLabelTextStyle,
            indicator: _indicator,
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: widget.tabAlignment,
            isScrollable: true,
            dividerHeight: 1,
            dividerColor: AppColors.white3Color,
            tabs: _visibleTabs
                .sorted(
                  (a, b) {
                var aIndex = a.index?.value ?? 0;
                var bIndex = b.index?.value ?? 0;
                return aIndex.compareTo(bIndex);
              },
            )
                .mapIndexed((itemIndex, e) => AnimatedBuilder(
                animation: _tabController.animation!,
                builder: (_, __) {
                  return Container(
                      padding: EdgeInsets.only(
                          top: _topPadding(itemIndex),
                          bottom: _bottomPadding(itemIndex)),
                      child: _buildTabBar(
                          e, itemIndex == _tabController.index)
                    // child: Text(e.title.toUpperCase(), style: _labelTextStyle,)
                  );
                }))
                .toList())
            .makeColor(Colors.white),
        Expanded(
            child: TabBarView(
                controller: _tabController,
                children: _visibleTabs
                    .mapIndexed((index, element) => KeepAliveWrapper(
                    key: element._key, child: element.body))
                    .toList()))
      ],
    );
  }

  Widget _buildTabBar(TabBarViewData data, bool isSelected) {
    if (data._isNormalTabBar) {
      return RichText(
          textScaler: MediaQuery.of(context).textScaler,
          text: TextSpan(
            children: [
              TextSpan(
                  text: _capitalized(data.title ?? ''),
                  style:
                  isSelected ? _labelTextStyle : _unselectedLabelTextStyle),
              if (data.shouldIncludeAsterisk)
                TextSpan(
                    text: ' *',
                    style: _labelTextStyle.textColor(Colors.redAccent)),
            ],
          ));
    }

    return isSelected
        ? data.widgetTitle!
        : (data.widgetUnselectedTitle ?? data.widgetTitle!);
  }

  EdgeInsetsGeometry get _labelPadding =>
      const EdgeInsets.symmetric(horizontal: 16);

  TextStyle get _labelTextStyle => const TextStyle()
      .textColor(AppColors.mainColor)
      .size(14)
      .weight(FontWeight.w400);

  TextStyle get _unselectedLabelTextStyle =>
      _labelTextStyle.copyWith(color: AppColors.black1Color);

  Decoration get _indicator => UnderlineTabIndicator(
      borderSide: const BorderSide(width: 4, color: AppColors.mainColor),
      borderRadius:
      BorderRadius.only(topLeft: _borderRadius, topRight: _borderRadius));

  Radius get _borderRadius => const Radius.circular(4.0);

  /// The calculation explained below
  /// The current tab changes to the relative index (can be next or previous tab)
  /// The index of the tab will be 0, 1, 2, 3, 4,... etc
  ///
  /// Given that the title's position will be up when focused and down when not focused
  /// This position is determined by the padding of the title
  /// And we have to calculate the change of the amount value will be added or minus to the padding to make this kind of animation
  ///
  /// The padding has to be changed between a lower bound and an upper bound value
  /// to make sure the title's position will have the up and down animation
  /// To make sure the animation of title is smooth and synchronized with the gesture of the user's finger
  /// The padding has to be synchronized with the animation value of the tabController
  ///
  /// The formula of factor of change will be (animation.value - itemIndex).abs().clamp(0, 1) * _baseAmount
  ///
  /// _baseAmount is the value which topPadding and bottomPadding will add or minus when the tab is focused
  /// The (animation.value - index) value represents the change of tab from unselected to selected state, and it will be from 0 to 1 for each tab
  /// The clamp() function will make sure that the value will be only between 0 and 1

  final _baseAmount = 3;

  double _topPadding(int itemIndex) {
    const baseTopPadding = 14.0;
    final animationValue = _tabController.animation?.value ?? 0;
    final increasingAmount =
        (animationValue - itemIndex).abs().clamp(0, 1) * _baseAmount;

    return baseTopPadding + increasingAmount;
  }

  double _bottomPadding(int itemIndex) {
    const baseBottomPadding = 12.0;
    final animationValue = _tabController.animation?.value ?? 0;
    final decreasingAmount =
        (animationValue - itemIndex).abs().clamp(0, 1) * _baseAmount;

    return baseBottomPadding - decreasingAmount;
  }

  String _capitalized(String text) {
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }
}

class BaseTabBarViewNotifier {
  final _tabBarIndexChangedNotifier = StreamController<TabBarViewIndex>();
  final _tabBarVisibilityChangedNotifier = StreamController<int>();
  var _visibilityCounter = 0;

  void animateAndRebuildTab(TabBarViewIndex tabBarViewIndex) => _tabBarIndexChangedNotifier.sink.add(tabBarViewIndex);

  void updateTabVisibility() => _tabBarVisibilityChangedNotifier.sink.add(_visibilityCounter++);

  void dispose() {
    _tabBarIndexChangedNotifier.close();
    _tabBarVisibilityChangedNotifier.close();
  }
}

class TabBarViewData {
  final String? title;
  final Widget? widgetTitle;
  final Widget? widgetUnselectedTitle;
  final Widget body;
  final bool shouldIncludeAsterisk;
  final TabBarViewIndex? index;
  final GlobalKey _key;

  TabBarViewData.normal({
    required this.title,
    required this.body,
    this.index,
    this.shouldIncludeAsterisk = false
  }): widgetTitle = null, widgetUnselectedTitle = null, _key = GlobalValueKey(index ?? title);

  TabBarViewData.custom({
    required this.widgetTitle,
    this.widgetUnselectedTitle,
    this.index,
    required this.body
  }) : title = null, shouldIncludeAsterisk = false, _key = GlobalValueKey(index ?? widgetTitle);

  bool get _isNormalTabBar => title.isNotNull;
}

abstract interface class TabBarViewIndex {
  int get value;

  bool get visible;
}

class RawTabBarViewIndex implements TabBarViewIndex {
  final int _value;
  final bool _visible;

  const RawTabBarViewIndex._(this._value, {bool visible = false})
      : _visible = visible;

  factory RawTabBarViewIndex.value({required int value, bool visible = false}) {
    return RawTabBarViewIndex._(value, visible: visible);
  }

  @override
  int get value => _value;

  @override
  bool get visible => _visible;
}
