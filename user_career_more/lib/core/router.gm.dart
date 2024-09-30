// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:user_career_more/calendar/pages/calendar_page.dart' as _i2;
import 'package:user_career_more/change_password/pages/change_password_page.dart'
    as _i3;
import 'package:user_career_more/core/tab_router.dart' as _i13;
import 'package:user_career_more/expect_certificates/pages/expect_certificates_page.dart'
    as _i5;
import 'package:user_career_more/expect_experiences/models/expect_experience_response.dart'
    as _i19;
import 'package:user_career_more/expect_experiences/pages/add_experience_page.dart'
    as _i1;
import 'package:user_career_more/expect_experiences/pages/edit_experience_page.dart'
    as _i4;
import 'package:user_career_more/expect_experiences/pages/expect_experiences_page.dart'
    as _i6;
import 'package:user_career_more/expect_experiences/pages/filter_categories_page.dart'
    as _i10;
import 'package:user_career_more/expect_experiences/pages/filter_edit_category_page.dart'
    as _i11;
import 'package:user_career_more/expect_price_service/pages/expect_price_service_page.dart'
    as _i8;
import 'package:user_career_more/expect_skills/pages/expect_skills_page.dart'
    as _i9;
import 'package:user_career_more/more/pages/expect_page.dart' as _i7;
import 'package:user_career_more/more/pages/more_page.dart' as _i12;
import 'package:user_career_more/service/pages/service_page.dart' as _i14;
import 'package:user_career_more/update_information/pages/update_information_page.dart'
    as _i15;
import 'package:user_career_more/wallet/pages/wallet_page.dart' as _i16;

abstract class $MoreRouterModule extends _i17.AutoRouterModule {
  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    AddExperienceRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddExperiencePage(),
      );
    },
    CalendarRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CalendarPage(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ChangePasswordPage(),
      );
    },
    EditExperienceRoute.name: (routeData) {
      final args = routeData.argsAs<EditExperienceRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.EditExperiencePage(
          key: args.key,
          expectExperienceResponse: args.expectExperienceResponse,
        ),
      );
    },
    ExpectCertificatesRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ExpectCertificatesPage(),
      );
    },
    ExpectExperiencesRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ExpectExperiencesPage(),
      );
    },
    ExpectRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ExpectPage(),
      );
    },
    ExpectPriceServiceRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ExpectPriceServicePage(),
      );
    },
    ExpectSkillsRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ExpectSkillsPage(),
      );
    },
    FilterCategoriesRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.FilterCategoriesPage(),
      );
    },
    FilterEditCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<FilterEditCategoryRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.FilterEditCategoryPage(
          key: args.key,
          expectExperienceResponse: args.expectExperienceResponse,
        ),
      );
    },
    MoreRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.MorePage(),
      );
    },
    MoreTabRouter.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.MoreTabRouter(),
      );
    },
    ServiceRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.ServicePage(),
      );
    },
    UpdateInformationRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.UpdateInformationPage(),
      );
    },
    WalletRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.WalletPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddExperiencePage]
class AddExperienceRoute extends _i17.PageRouteInfo<void> {
  const AddExperienceRoute({List<_i17.PageRouteInfo>? children})
      : super(
          AddExperienceRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddExperienceRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CalendarPage]
class CalendarRoute extends _i17.PageRouteInfo<void> {
  const CalendarRoute({List<_i17.PageRouteInfo>? children})
      : super(
          CalendarRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChangePasswordPage]
class ChangePasswordRoute extends _i17.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EditExperiencePage]
class EditExperienceRoute extends _i17.PageRouteInfo<EditExperienceRouteArgs> {
  EditExperienceRoute({
    _i18.Key? key,
    required _i19.ExpectExperienceResponse expectExperienceResponse,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          EditExperienceRoute.name,
          args: EditExperienceRouteArgs(
            key: key,
            expectExperienceResponse: expectExperienceResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'EditExperienceRoute';

  static const _i17.PageInfo<EditExperienceRouteArgs> page =
      _i17.PageInfo<EditExperienceRouteArgs>(name);
}

class EditExperienceRouteArgs {
  const EditExperienceRouteArgs({
    this.key,
    required this.expectExperienceResponse,
  });

  final _i18.Key? key;

  final _i19.ExpectExperienceResponse expectExperienceResponse;

  @override
  String toString() {
    return 'EditExperienceRouteArgs{key: $key, expectExperienceResponse: $expectExperienceResponse}';
  }
}

/// generated route for
/// [_i5.ExpectCertificatesPage]
class ExpectCertificatesRoute extends _i17.PageRouteInfo<void> {
  const ExpectCertificatesRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ExpectCertificatesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectCertificatesRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ExpectExperiencesPage]
class ExpectExperiencesRoute extends _i17.PageRouteInfo<void> {
  const ExpectExperiencesRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ExpectExperiencesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectExperiencesRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ExpectPage]
class ExpectRoute extends _i17.PageRouteInfo<void> {
  const ExpectRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ExpectRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ExpectPriceServicePage]
class ExpectPriceServiceRoute extends _i17.PageRouteInfo<void> {
  const ExpectPriceServiceRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ExpectPriceServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectPriceServiceRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ExpectSkillsPage]
class ExpectSkillsRoute extends _i17.PageRouteInfo<void> {
  const ExpectSkillsRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ExpectSkillsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectSkillsRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i10.FilterCategoriesPage]
class FilterCategoriesRoute extends _i17.PageRouteInfo<void> {
  const FilterCategoriesRoute({List<_i17.PageRouteInfo>? children})
      : super(
          FilterCategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilterCategoriesRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i11.FilterEditCategoryPage]
class FilterEditCategoryRoute
    extends _i17.PageRouteInfo<FilterEditCategoryRouteArgs> {
  FilterEditCategoryRoute({
    _i18.Key? key,
    required _i19.ExpectExperienceResponse expectExperienceResponse,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          FilterEditCategoryRoute.name,
          args: FilterEditCategoryRouteArgs(
            key: key,
            expectExperienceResponse: expectExperienceResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'FilterEditCategoryRoute';

  static const _i17.PageInfo<FilterEditCategoryRouteArgs> page =
      _i17.PageInfo<FilterEditCategoryRouteArgs>(name);
}

class FilterEditCategoryRouteArgs {
  const FilterEditCategoryRouteArgs({
    this.key,
    required this.expectExperienceResponse,
  });

  final _i18.Key? key;

  final _i19.ExpectExperienceResponse expectExperienceResponse;

  @override
  String toString() {
    return 'FilterEditCategoryRouteArgs{key: $key, expectExperienceResponse: $expectExperienceResponse}';
  }
}

/// generated route for
/// [_i12.MorePage]
class MoreRoute extends _i17.PageRouteInfo<void> {
  const MoreRoute({List<_i17.PageRouteInfo>? children})
      : super(
          MoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoreRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i13.MoreTabRouter]
class MoreTabRouter extends _i17.PageRouteInfo<void> {
  const MoreTabRouter({List<_i17.PageRouteInfo>? children})
      : super(
          MoreTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'MoreTabRouter';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i14.ServicePage]
class ServiceRoute extends _i17.PageRouteInfo<void> {
  const ServiceRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'ServiceRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i15.UpdateInformationPage]
class UpdateInformationRoute extends _i17.PageRouteInfo<void> {
  const UpdateInformationRoute({List<_i17.PageRouteInfo>? children})
      : super(
          UpdateInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateInformationRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i16.WalletPage]
class WalletRoute extends _i17.PageRouteInfo<void> {
  const WalletRoute({List<_i17.PageRouteInfo>? children})
      : super(
          WalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}
