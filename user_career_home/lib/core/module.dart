import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/core/router.gm.dart';

import 'notification_type.dart';

class HomeModule extends AutoRoutePageModule with NotificationTypeMixin<NotificationType>{
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

  @override
  NotificationType filterNotificationType(Map<String, dynamic>? data) {
    var type = data?['type'];
    return NotificationType.fromString(type);
  }

  @override
  Future onNavigateFromNotification(NotificationType notificationType,
      Map<String, dynamic>? data) async {
    var expertId = data?['expert_id'];
    
    switch (notificationType) {
      case NotificationType.requestDetail:
        appRouter.push(ExpectDetailRoute(expectId: expertId));
        break;
      case NotificationType.booking:
        appRouter.push(BookingRoute());
        break;
      case NotificationType.none:
      // TODO: Handle this case.
    }
  }
}