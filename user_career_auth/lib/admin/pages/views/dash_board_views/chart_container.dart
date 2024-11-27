import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

typedef ChartBuilder<T> = Widget Function(
    BuildContext context, WidgetRef ref, T data, double height);

const _totalExpandedIconSpace = 52;

class ChartContainer<T> extends ConsumerStatefulWidget {
  final double width;
  final double height;
  final AsyncValue<T> data;
  final ChartBuilder<T> chartBuilder;
  // final List<SSOPermission> permissions;
  final Function? reloadData;
  final bool Function(T)? shouldBuildEmptyDataPlaceholder;
  final bool shouldShowExpandedButton;
  final void Function(T)? onTapExpandedButton;

  @override
  ConsumerState createState() => _CRMChartViewState<T>();

  const ChartContainer({
    super.key,
    this.width = double.infinity,
    required this.height,
    required this.data,
    required this.chartBuilder,
    // required this.permissions,
    this.reloadData,
    this.shouldBuildEmptyDataPlaceholder,
    this.shouldShowExpandedButton = true,
    this.onTapExpandedButton,
  });
}

class _CRMChartViewState<T> extends ConsumerState<ChartContainer<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        height: widget.height + _totalExpandedIconSpace,
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 0),
              blurRadius: 12,
            ),
          ],
        ),
        child: widget.data.maybeWhen(
          skipError: true,
          skipLoadingOnReload: false,
          skipLoadingOnRefresh: false,
          loading: () => LoadingIndicator(
            backgroundColor: Colors.transparent,
            indicatorType: Indicator.ballPulse,
            colors: [
              AppColors.mainColor,
              AppColors.mainColor.withOpacity(0.8),
              AppColors.mainColor.withOpacity(0.6),
            ],
          ).box(h: 25, w: 36).center(),
          orElse: () => _loadChartFailedPlaceholder,
          data: (data) {
            return Visibility(
                visible: widget.shouldBuildEmptyDataPlaceholder?.call(data) ==
                    true,
                replacement: Column(
                  children: [
                    widget.shouldShowExpandedButton
                        ? IconButton(
                        onPressed: () => widget.onTapExpandedButton?.call(data),
                        icon: Assets.icons.icExpand2
                            .svg()
                            .box(h: 24, w: 24))
                        .topRight()
                        : const SizedBox.shrink(),
                    widget
                        .chartBuilder(context, ref, data, widget.height)
                        .animate()
                        .fadeIn(
                        duration: 250.milliseconds,
                        begin: 0,
                        curve: Curves.fastOutSlowIn)
                        .flexible(),
                  ],
                ),
                child: _emptyDataPlaceholder);
          },
        ));
  }

  Widget get _loadChartFailedPlaceholder => ConstrainedBox(
      constraints:
      BoxConstraints(maxHeight: widget.height, maxWidth: widget.width),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const EmptyView(),
          Assets.icons.icLoadChartFailed.svg(),
          const Gap(4),
          Text("Tải biểu đồ thất bại",
              style: ref.theme.mediumTextStyle,
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(100)),
            child: Text("Tải lại biểu đồ",
                style: ref.theme
                    .defaultTextStyle
                    .textColor(Colors.white)),
          ).onTapWidget(() {
            widget.reloadData?.call();
          }, radius: 100)
        ],
      ));

  Widget get _emptyDataPlaceholder => ConstrainedBox(
      constraints:
      BoxConstraints(maxHeight: widget.height, maxWidth: widget.width),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.icChartEmptyData.svg(),
          const Gap(4),
          Text("Không có dữ liệu",
              style: ref.theme.mediumTextStyle,),
          const Gap(20),
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          //   decoration: BoxDecoration(
          //       color: AppColors.primary1,
          //       borderRadius: BorderRadius.circular(100)),
          //   child: Text(L.common.reloadChart,
          //       style: ref.theme
          //           .customStyle(AppStyles.base14Medium)
          //           .textColor(Colors.white)),
          // ).onTapWidget(() {
          //   widget.reloadData?.call();
          // }, radius: 100)
        ],
      ));
}
