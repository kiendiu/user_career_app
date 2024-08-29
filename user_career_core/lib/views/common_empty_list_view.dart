import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

import 'app_button.dart';

class CommonEmptyListView extends ConsumerStatefulWidget {
  String? emptyResultMessage;
  final void Function() onRefresh;
  CommonEmptyListView({super.key, required this.onRefresh, this.emptyResultMessage});

  @override
  ConsumerState<CommonEmptyListView> createState() => _CommonEmptyListViewState();
}

class _CommonEmptyListViewState extends ConsumerState<CommonEmptyListView> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.icNoPermission.svg(),
          Text(
            widget.emptyResultMessage ?? L.common.emptyList,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff242133),
            ),
          ).marginOnly(top: 16),
          AppButton(
            title: L.common.refreshText,
            onPressed: widget.onRefresh,
            borderRadius: 100.0.borderAll(),
          )
              .marginOnly(top: 12)
              .paddingSymmetric(horizontal: context.width / 3),
        ],
      );
    });
  }
}
