import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/core/router.gm.dart';

class RequestModule extends AutoRoutePageModule {
  RequestModule(super.env)
      : super(
      firstRoute: const RequestRoute(),
      visible: true,
      item: BottomNavigationBarItem(
          label: L.common.tabBar.request,
          activeIcon: Consumer(
            builder: (context, ref, child) {
              return Assets.icons.icTabbarRequest.svg(width: 24, height: 24);
            },
          ),
          icon: Assets.icons.icTabbarUnselectedRequest
              .svg(width: 24, height: 24)));
}