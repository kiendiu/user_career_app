// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i22;
import 'package:flutter/cupertino.dart' as _i26;
import 'package:flutter/material.dart' as _i23;
import 'package:user_career_more/calendar/pages/calendar_page.dart' as _i4;
import 'package:user_career_more/change_password/pages/change_password_page.dart'
    as _i5;
import 'package:user_career_more/core/tab_router.dart' as _i16;
import 'package:user_career_more/expect_certificates/models/certificate_response.dart'
    as _i27;
import 'package:user_career_more/expect_certificates/pages/add_certificate_page.dart'
    as _i1;
import 'package:user_career_more/expect_certificates/pages/expect_certificates_page.dart'
    as _i7;
import 'package:user_career_more/expect_certificates/pages/update_certificate_page.dart'
    as _i18;
import 'package:user_career_more/expect_experiences/models/expect_experience_response.dart'
    as _i24;
import 'package:user_career_more/expect_experiences/pages/add_experience_page.dart'
    as _i2;
import 'package:user_career_more/expect_experiences/pages/edit_experience_page.dart'
    as _i6;
import 'package:user_career_more/expect_experiences/pages/expect_experiences_page.dart'
    as _i8;
import 'package:user_career_more/expect_experiences/pages/filter_edit_category_page.dart'
    as _i13;
import 'package:user_career_more/expect_price_service/pages/expect_price_service_page.dart'
    as _i10;
import 'package:user_career_more/expect_skills/models/skill_response.dart'
    as _i25;
import 'package:user_career_more/expect_skills/pages/add_skill_page.dart'
    as _i3;
import 'package:user_career_more/expect_skills/pages/expect_skills_page.dart'
    as _i11;
import 'package:user_career_more/expect_skills/pages/filter_categories_page.dart'
    as _i12;
import 'package:user_career_more/expect_skills/pages/filter_update_category_page.dart'
    as _i14;
import 'package:user_career_more/expect_skills/pages/update_skill_page.dart'
    as _i20;
import 'package:user_career_more/more/pages/expect_page.dart' as _i9;
import 'package:user_career_more/more/pages/more_page.dart' as _i15;
import 'package:user_career_more/service/pages/service_page.dart' as _i17;
import 'package:user_career_more/update_information/pages/update_information_page.dart'
    as _i19;
import 'package:user_career_more/wallet/pages/wallet_page.dart' as _i21;

abstract class $MoreRouterModule extends _i22.AutoRouterModule {
  @override
  final Map<String, _i22.PageFactory> pagesMap = {
    AddCertificateRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddCertificatePage(),
      );
    },
    AddExperienceRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AddExperiencePage(),
      );
    },
    AddSkillRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AddSkillPage(),
      );
    },
    CalendarRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CalendarPage(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ChangePasswordPage(),
      );
    },
    EditExperienceRoute.name: (routeData) {
      final args = routeData.argsAs<EditExperienceRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.EditExperiencePage(
          key: args.key,
          expectExperienceResponse: args.expectExperienceResponse,
        ),
      );
    },
    ExpectCertificatesRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ExpectCertificatesPage(),
      );
    },
    ExpectExperiencesRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ExpectExperiencesPage(),
      );
    },
    ExpectRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ExpectPage(),
      );
    },
    ExpectPriceServiceRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ExpectPriceServicePage(),
      );
    },
    ExpectSkillsRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ExpectSkillsPage(),
      );
    },
    FilterCategoriesRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.FilterCategoriesPage(),
      );
    },
    FilterEditCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<FilterEditCategoryRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.FilterEditCategoryPage(
          key: args.key,
          expectExperienceResponse: args.expectExperienceResponse,
        ),
      );
    },
    FilterUpdateCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<FilterUpdateCategoryRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.FilterUpdateCategoryPage(
          key: args.key,
          skillResponse: args.skillResponse,
        ),
      );
    },
    MoreRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.MorePage(),
      );
    },
    MoreTabRouter.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.MoreTabRouter(),
      );
    },
    ServiceRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.ServicePage(),
      );
    },
    UpdateCertificateRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateCertificateRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.UpdateCertificatePage(
          key: args.key,
          certificateResponse: args.certificateResponse,
        ),
      );
    },
    UpdateInformationRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.UpdateInformationPage(),
      );
    },
    UpdateSkillRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateSkillRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.UpdateSkillPage(
          key: args.key,
          skillResponse: args.skillResponse,
        ),
      );
    },
    WalletRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.WalletPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddCertificatePage]
class AddCertificateRoute extends _i22.PageRouteInfo<void> {
  const AddCertificateRoute({List<_i22.PageRouteInfo>? children})
      : super(
          AddCertificateRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddCertificateRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddExperiencePage]
class AddExperienceRoute extends _i22.PageRouteInfo<void> {
  const AddExperienceRoute({List<_i22.PageRouteInfo>? children})
      : super(
          AddExperienceRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddExperienceRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AddSkillPage]
class AddSkillRoute extends _i22.PageRouteInfo<void> {
  const AddSkillRoute({List<_i22.PageRouteInfo>? children})
      : super(
          AddSkillRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddSkillRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CalendarPage]
class CalendarRoute extends _i22.PageRouteInfo<void> {
  const CalendarRoute({List<_i22.PageRouteInfo>? children})
      : super(
          CalendarRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChangePasswordPage]
class ChangePasswordRoute extends _i22.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i22.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EditExperiencePage]
class EditExperienceRoute extends _i22.PageRouteInfo<EditExperienceRouteArgs> {
  EditExperienceRoute({
    _i23.Key? key,
    required _i24.ExpectExperienceResponse expectExperienceResponse,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          EditExperienceRoute.name,
          args: EditExperienceRouteArgs(
            key: key,
            expectExperienceResponse: expectExperienceResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'EditExperienceRoute';

  static const _i22.PageInfo<EditExperienceRouteArgs> page =
      _i22.PageInfo<EditExperienceRouteArgs>(name);
}

class EditExperienceRouteArgs {
  const EditExperienceRouteArgs({
    this.key,
    required this.expectExperienceResponse,
  });

  final _i23.Key? key;

  final _i24.ExpectExperienceResponse expectExperienceResponse;

  @override
  String toString() {
    return 'EditExperienceRouteArgs{key: $key, expectExperienceResponse: $expectExperienceResponse}';
  }
}

/// generated route for
/// [_i7.ExpectCertificatesPage]
class ExpectCertificatesRoute extends _i22.PageRouteInfo<void> {
  const ExpectCertificatesRoute({List<_i22.PageRouteInfo>? children})
      : super(
          ExpectCertificatesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectCertificatesRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ExpectExperiencesPage]
class ExpectExperiencesRoute extends _i22.PageRouteInfo<void> {
  const ExpectExperiencesRoute({List<_i22.PageRouteInfo>? children})
      : super(
          ExpectExperiencesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectExperiencesRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ExpectPage]
class ExpectRoute extends _i22.PageRouteInfo<void> {
  const ExpectRoute({List<_i22.PageRouteInfo>? children})
      : super(
          ExpectRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ExpectPriceServicePage]
class ExpectPriceServiceRoute extends _i22.PageRouteInfo<void> {
  const ExpectPriceServiceRoute({List<_i22.PageRouteInfo>? children})
      : super(
          ExpectPriceServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectPriceServiceRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ExpectSkillsPage]
class ExpectSkillsRoute extends _i22.PageRouteInfo<void> {
  const ExpectSkillsRoute({List<_i22.PageRouteInfo>? children})
      : super(
          ExpectSkillsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectSkillsRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i12.FilterCategoriesPage]
class FilterCategoriesRoute extends _i22.PageRouteInfo<void> {
  const FilterCategoriesRoute({List<_i22.PageRouteInfo>? children})
      : super(
          FilterCategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilterCategoriesRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i13.FilterEditCategoryPage]
class FilterEditCategoryRoute
    extends _i22.PageRouteInfo<FilterEditCategoryRouteArgs> {
  FilterEditCategoryRoute({
    _i23.Key? key,
    required _i24.ExpectExperienceResponse expectExperienceResponse,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          FilterEditCategoryRoute.name,
          args: FilterEditCategoryRouteArgs(
            key: key,
            expectExperienceResponse: expectExperienceResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'FilterEditCategoryRoute';

  static const _i22.PageInfo<FilterEditCategoryRouteArgs> page =
      _i22.PageInfo<FilterEditCategoryRouteArgs>(name);
}

class FilterEditCategoryRouteArgs {
  const FilterEditCategoryRouteArgs({
    this.key,
    required this.expectExperienceResponse,
  });

  final _i23.Key? key;

  final _i24.ExpectExperienceResponse expectExperienceResponse;

  @override
  String toString() {
    return 'FilterEditCategoryRouteArgs{key: $key, expectExperienceResponse: $expectExperienceResponse}';
  }
}

/// generated route for
/// [_i14.FilterUpdateCategoryPage]
class FilterUpdateCategoryRoute
    extends _i22.PageRouteInfo<FilterUpdateCategoryRouteArgs> {
  FilterUpdateCategoryRoute({
    _i23.Key? key,
    required _i25.SkillResponse skillResponse,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          FilterUpdateCategoryRoute.name,
          args: FilterUpdateCategoryRouteArgs(
            key: key,
            skillResponse: skillResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'FilterUpdateCategoryRoute';

  static const _i22.PageInfo<FilterUpdateCategoryRouteArgs> page =
      _i22.PageInfo<FilterUpdateCategoryRouteArgs>(name);
}

class FilterUpdateCategoryRouteArgs {
  const FilterUpdateCategoryRouteArgs({
    this.key,
    required this.skillResponse,
  });

  final _i23.Key? key;

  final _i25.SkillResponse skillResponse;

  @override
  String toString() {
    return 'FilterUpdateCategoryRouteArgs{key: $key, skillResponse: $skillResponse}';
  }
}

/// generated route for
/// [_i15.MorePage]
class MoreRoute extends _i22.PageRouteInfo<void> {
  const MoreRoute({List<_i22.PageRouteInfo>? children})
      : super(
          MoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoreRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i16.MoreTabRouter]
class MoreTabRouter extends _i22.PageRouteInfo<void> {
  const MoreTabRouter({List<_i22.PageRouteInfo>? children})
      : super(
          MoreTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'MoreTabRouter';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i17.ServicePage]
class ServiceRoute extends _i22.PageRouteInfo<void> {
  const ServiceRoute({List<_i22.PageRouteInfo>? children})
      : super(
          ServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'ServiceRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i18.UpdateCertificatePage]
class UpdateCertificateRoute
    extends _i22.PageRouteInfo<UpdateCertificateRouteArgs> {
  UpdateCertificateRoute({
    _i26.Key? key,
    required _i27.CertificateResponse certificateResponse,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          UpdateCertificateRoute.name,
          args: UpdateCertificateRouteArgs(
            key: key,
            certificateResponse: certificateResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateCertificateRoute';

  static const _i22.PageInfo<UpdateCertificateRouteArgs> page =
      _i22.PageInfo<UpdateCertificateRouteArgs>(name);
}

class UpdateCertificateRouteArgs {
  const UpdateCertificateRouteArgs({
    this.key,
    required this.certificateResponse,
  });

  final _i26.Key? key;

  final _i27.CertificateResponse certificateResponse;

  @override
  String toString() {
    return 'UpdateCertificateRouteArgs{key: $key, certificateResponse: $certificateResponse}';
  }
}

/// generated route for
/// [_i19.UpdateInformationPage]
class UpdateInformationRoute extends _i22.PageRouteInfo<void> {
  const UpdateInformationRoute({List<_i22.PageRouteInfo>? children})
      : super(
          UpdateInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateInformationRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i20.UpdateSkillPage]
class UpdateSkillRoute extends _i22.PageRouteInfo<UpdateSkillRouteArgs> {
  UpdateSkillRoute({
    _i23.Key? key,
    required _i25.SkillResponse skillResponse,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          UpdateSkillRoute.name,
          args: UpdateSkillRouteArgs(
            key: key,
            skillResponse: skillResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateSkillRoute';

  static const _i22.PageInfo<UpdateSkillRouteArgs> page =
      _i22.PageInfo<UpdateSkillRouteArgs>(name);
}

class UpdateSkillRouteArgs {
  const UpdateSkillRouteArgs({
    this.key,
    required this.skillResponse,
  });

  final _i23.Key? key;

  final _i25.SkillResponse skillResponse;

  @override
  String toString() {
    return 'UpdateSkillRouteArgs{key: $key, skillResponse: $skillResponse}';
  }
}

/// generated route for
/// [_i21.WalletPage]
class WalletRoute extends _i22.PageRouteInfo<void> {
  const WalletRoute({List<_i22.PageRouteInfo>? children})
      : super(
          WalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}
