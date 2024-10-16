import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/base_app_bar_view.dart';
import 'package:user_career_core/views/base_tab_bar_view.dart';
import 'package:user_career_request/request/pages/views/bid_view.dart';
import 'package:user_career_request/request/pages/views/mine_view.dart';

import 'views/general_view.dart';

@RoutePage()
class RequestPage extends ConsumerStatefulWidget {
  const RequestPage({super.key});

  @override
  ConsumerState createState() => _RequestPageState();
}

class _RequestPageState extends ConsumerState<RequestPage> with SingleTickerProviderStateMixin {
  final _appBarController = BaseAppBarController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: BaseAppBarView(
        title: "Yêu cầu",
        controller: _appBarController,
        shouldShowLeading: false,
      ),
      body: BaseTabBarView(
        data: [
          TabBarViewData.normal(
              title: "Dịch vụ",
              body: const GeneralPage()),
          TabBarViewData.normal(
              title: "Của tôi",
              body: const MinePage()),
          TabBarViewData.normal(
              title: "Chào giá",
              body: const BidPage()),
        ],
      ),
    );
  }
}