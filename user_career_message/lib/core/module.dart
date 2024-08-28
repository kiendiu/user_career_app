
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_message/core/router.gm.dart';

class MessageModule extends AutoRoutePageModule {
  MessageModule(super.env)
      : super(
      firstRoute: const MessageRoute(),
      visible: true,
      item: BottomNavigationBarItem(
          label: L.common.tabBar.message,
          activeIcon: Consumer(
            builder: (context, ref, child) {
              return Assets.icons.icTabbarMessage.svg(width: 24, height: 24);
            },
          ),
          icon: Assets.icons.icTabbarUnselectedMessage
              .svg(width: 24, height: 24)));
}