import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

class AppBottomNavigationBar extends ConsumerStatefulWidget {
  final List<AutoRoutePageModule> modules;
  final TabsRouter router;

  const AppBottomNavigationBar(
      {super.key, required this.modules, required this.router});

  @override
  ConsumerState<AppBottomNavigationBar> createState() =>
      _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState
    extends ConsumerState<AppBottomNavigationBar> {
  late int numberOfModules = widget.modules.length;
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 16,
          spreadRadius: 0,
          offset: Offset(0, 0),
        ),
      ], color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TweenAnimationBuilder(
            curve: Curves.fastOutSlowIn,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(value, 0),
                child: child,
              );
            },
            tween: Tween<double>(
                begin: 0, end: context.width / numberOfModules * page),
            duration: const Duration(milliseconds: 200),
            child: SizedBox(
              height: 3,
              width: context.width / numberOfModules,
              child: const LineSeparator(
                margin: EdgeInsets.only(right: 16.0, left: 16.0),
                height: 3,
                color: AppColors.main1Color,
              ),
            ),
          ),
          Theme(
            data: ThemeData(
              splashFactory: NoSplash.splashFactory,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.main1Color,
              unselectedItemColor: AppColors.tabbarTitle,
              selectedLabelStyle: ref.theme.smallTextStyle,
              unselectedLabelStyle: ref.theme.smallTextStyle,
              currentIndex: page,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                widget.router.setActiveIndex(value);
                page = value;
                setState(() {});
              },
              items: widget.modules.map((e) => e.item).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
