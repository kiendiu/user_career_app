import 'package:flutter/material.dart';
import 'package:user_career_core/user_career_core.dart';

class AppServiceUnavailableHandler with ServiceUnavailableHandler {
  @override
  onShowServiceUnavailablePage() {
    appRouter.pushWidget(
      Scaffold(
        body: const Text(
          "Oops! Something went wrong",
          style: TextStyle(fontSize: 20, color: AppColors.black1Color),
        ).center().defaultHorizontalPadding(),
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          )),
          child: child,
        );
      },
    );
  }
}