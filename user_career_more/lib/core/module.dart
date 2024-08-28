
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/router.gm.dart';

class MoreModule extends AutoRoutePageModule {
  MoreModule(super.env)
      : super(
      firstRoute: const MoreRoute(),
      visible: true,
      item: BottomNavigationBarItem(
          label: L.common.tabBar.more,
          activeIcon: Consumer(
            builder: (context, ref, child) {
              return Assets.icons.icTabbarUser.svg(width: 24, height: 24);
            },
          ),
          icon: Assets.icons.icTabbarUnselectedUser
              .svg(width: 24, height: 24)));
}