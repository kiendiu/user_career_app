import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/core/router.gm.dart';
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
      fab: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          context.pushRoute(const AddRequestRoute());
        },
        child: const Icon(Icons.add, color: AppColors.white1Color,),
      ),
      body: BaseTabBarView(
        data: [
          TabBarViewData.normal(
              title: "Yêu cầu dịch vụ",
              body: const GeneralPage()),
          TabBarViewData.normal(
              title: "Yêu cầu của tôi",
              body: const MinePage()),
          // TabBarViewData.normal(
          //     title: "Chào giá",
          //     body: const BidPage()),
        ],
      ),
    );
  }
}