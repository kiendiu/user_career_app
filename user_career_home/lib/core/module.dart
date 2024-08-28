import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/core/router.gm.dart';

class HomeModule extends AutoRoutePageModule {
  HomeModule(super.env)
      : super(
      firstRoute: const HomeRoute(),
      visible: true,
      item: BottomNavigationBarItem(
          label: L.common.tabBar.home,
          activeIcon: Consumer(
            builder: (context, ref, child) {
              return Assets.icons.icTabbarHome.svg(width: 24, height: 24);
            },
          ),
          icon: Assets.icons.icTabbarUnselectedHome
              .svg(width: 24, height: 24)));
}