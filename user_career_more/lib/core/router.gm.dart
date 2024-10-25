// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i23;
import 'package:flutter/material.dart' as _i24;
import 'package:user_career_more/calendar/pages/calendar_page.dart' as _i4;
import 'package:user_career_more/change_password/pages/change_password_page.dart'
    as _i5;
import 'package:user_career_more/core/tab_router.dart' as _i17;
import 'package:user_career_more/expect_certificates/models/certificate_response.dart'
    as _i28;
import 'package:user_career_more/expect_certificates/pages/add_certificate_page.dart'
    as _i1;
import 'package:user_career_more/expect_certificates/pages/expect_certificates_page.dart'
    as _i7;
import 'package:user_career_more/expect_certificates/pages/update_certificate_page.dart'
    as _i19;
import 'package:user_career_more/expect_experiences/models/expect_experience_response.dart'
    as _i25;
import 'package:user_career_more/expect_experiences/pages/add_experience_page.dart'
    as _i2;
import 'package:user_career_more/expect_experiences/pages/edit_experience_page.dart'
    as _i6;
import 'package:user_career_more/expect_experiences/pages/expect_experiences_page.dart'
    as _i8;
import 'package:user_career_more/expect_experiences/pages/filter_edit_category_page.dart'
    as _i13;
import 'package:user_career_more/expect_experiences/pages/filter_experience_categories_page.dart'
    as _i14;
import 'package:user_career_more/expect_price_service/pages/expect_price_service_page.dart'
    as _i10;
import 'package:user_career_more/expect_skills/models/skill_response.dart'
    as _i26;
import 'package:user_career_more/expect_skills/pages/add_skill_page.dart'
    as _i3;
import 'package:user_career_more/expect_skills/pages/expect_skills_page.dart'
    as _i11;
import 'package:user_career_more/expect_skills/pages/filter_categories_page.dart'
    as _i12;
import 'package:user_career_more/expect_skills/pages/filter_update_category_page.dart'
    as _i15;
import 'package:user_career_more/expect_skills/pages/update_skill_page.dart'
    as _i21;
import 'package:user_career_more/more/pages/expect_page.dart' as _i9;
import 'package:user_career_more/more/pages/more_page.dart' as _i16;
import 'package:user_career_more/service/models/status_service_enum.dart'
    as _i27;
import 'package:user_career_more/service/pages/service_page.dart' as _i18;
import 'package:user_career_more/update_information/pages/update_information_page.dart'
    as _i20;
import 'package:user_career_more/wallet/pages/wallet_page.dart' as _i22;

abstract class $MoreRouterModule extends _i23.AutoRouterModule {
  @override
  final Map<String, _i23.PageFactory> pagesMap = {
    AddCertificateRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddCertificatePage(),
      );
    },
    AddExperienceRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AddExperiencePage(),
      );
    },
    AddSkillRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AddSkillPage(),
      );
    },
    CalendarRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CalendarPage(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ChangePasswordPage(),
      );
    },
    EditExperienceRoute.name: (routeData) {
      final args = routeData.argsAs<EditExperienceRouteArgs>();
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.EditExperiencePage(
          key: args.key,
          expectExperienceResponse: args.expectExperienceResponse,
        ),
      );
    },
    ExpectCertificatesRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ExpectCertificatesPage(),
      );
    },
    ExpectExperiencesRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ExpectExperiencesPage(),
      );
    },
    ExpectRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ExpectPage(),
      );
    },
    ExpectPriceServiceRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ExpectPriceServicePage(),
      );
    },
    ExpectSkillsRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ExpectSkillsPage(),
      );
    },
    FilterCategoriesRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.FilterCategoriesPage(),
      );
    },
    FilterEditCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<FilterEditCategoryRouteArgs>();
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.FilterEditCategoryPage(
          key: args.key,
          expectExperienceResponse: args.expectExperienceResponse,
        ),
      );
    },
    FilterExperienceCategoriesRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.FilterExperienceCategoriesPage(),
      );
    },
    FilterUpdateCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<FilterUpdateCategoryRouteArgs>();
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.FilterUpdateCategoryPage(
          key: args.key,
          skillResponse: args.skillResponse,
        ),
      );
    },
    MoreRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.MorePage(),
      );
    },
    MoreTabRouter.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.MoreTabRouter(),
      );
    },
    ServiceRoute.name: (routeData) {
      final args = routeData.argsAs<ServiceRouteArgs>(
          orElse: () => const ServiceRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.ServicePage(
          key: args.key,
          selectedStatusOption: args.selectedStatusOption,
        ),
      );
    },
    UpdateCertificateRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateCertificateRouteArgs>();
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.UpdateCertificatePage(
          key: args.key,
          certificateResponse: args.certificateResponse,
        ),
      );
    },
    UpdateInformationRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.UpdateInformationPage(),
      );
    },
    UpdateSkillRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateSkillRouteArgs>();
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.UpdateSkillPage(
          key: args.key,
          skillResponse: args.skillResponse,
        ),
      );
    },
    WalletRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.WalletPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddCertificatePage]
class AddCertificateRoute extends _i23.PageRouteInfo<void> {
  const AddCertificateRoute({List<_i23.PageRouteInfo>? children})
      : super(
          AddCertificateRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddCertificateRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddExperiencePage]
class AddExperienceRoute extends _i23.PageRouteInfo<void> {
  const AddExperienceRoute({List<_i23.PageRouteInfo>? children})
      : super(
          AddExperienceRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddExperienceRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AddSkillPage]
class AddSkillRoute extends _i23.PageRouteInfo<void> {
  const AddSkillRoute({List<_i23.PageRouteInfo>? children})
      : super(
          AddSkillRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddSkillRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CalendarPage]
class CalendarRoute extends _i23.PageRouteInfo<void> {
  const CalendarRoute({List<_i23.PageRouteInfo>? children})
      : super(
          CalendarRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChangePasswordPage]
class ChangePasswordRoute extends _i23.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EditExperiencePage]
class EditExperienceRoute extends _i23.PageRouteInfo<EditExperienceRouteArgs> {
  EditExperienceRoute({
    _i24.Key? key,
    required _i25.ExpectExperienceResponse expectExperienceResponse,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          EditExperienceRoute.name,
          args: EditExperienceRouteArgs(
            key: key,
            expectExperienceResponse: expectExperienceResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'EditExperienceRoute';

  static const _i23.PageInfo<EditExperienceRouteArgs> page =
      _i23.PageInfo<EditExperienceRouteArgs>(name);
}

class EditExperienceRouteArgs {
  const EditExperienceRouteArgs({
    this.key,
    required this.expectExperienceResponse,
  });

  final _i24.Key? key;

  final _i25.ExpectExperienceResponse expectExperienceResponse;

  @override
  String toString() {
    return 'EditExperienceRouteArgs{key: $key, expectExperienceResponse: $expectExperienceResponse}';
  }
}

/// generated route for
/// [_i7.ExpectCertificatesPage]
class ExpectCertificatesRoute extends _i23.PageRouteInfo<void> {
  const ExpectCertificatesRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ExpectCertificatesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectCertificatesRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ExpectExperiencesPage]
class ExpectExperiencesRoute extends _i23.PageRouteInfo<void> {
  const ExpectExperiencesRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ExpectExperiencesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectExperiencesRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ExpectPage]
class ExpectRoute extends _i23.PageRouteInfo<void> {
  const ExpectRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ExpectRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ExpectPriceServicePage]
class ExpectPriceServiceRoute extends _i23.PageRouteInfo<void> {
  const ExpectPriceServiceRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ExpectPriceServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectPriceServiceRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ExpectSkillsPage]
class ExpectSkillsRoute extends _i23.PageRouteInfo<void> {
  const ExpectSkillsRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ExpectSkillsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpectSkillsRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i12.FilterCategoriesPage]
class FilterCategoriesRoute extends _i23.PageRouteInfo<void> {
  const FilterCategoriesRoute({List<_i23.PageRouteInfo>? children})
      : super(
          FilterCategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilterCategoriesRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i13.FilterEditCategoryPage]
class FilterEditCategoryRoute
    extends _i23.PageRouteInfo<FilterEditCategoryRouteArgs> {
  FilterEditCategoryRoute({
    _i24.Key? key,
    required _i25.ExpectExperienceResponse expectExperienceResponse,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          FilterEditCategoryRoute.name,
          args: FilterEditCategoryRouteArgs(
            key: key,
            expectExperienceResponse: expectExperienceResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'FilterEditCategoryRoute';

  static const _i23.PageInfo<FilterEditCategoryRouteArgs> page =
      _i23.PageInfo<FilterEditCategoryRouteArgs>(name);
}

class FilterEditCategoryRouteArgs {
  const FilterEditCategoryRouteArgs({
    this.key,
    required this.expectExperienceResponse,
  });

  final _i24.Key? key;

  final _i25.ExpectExperienceResponse expectExperienceResponse;

  @override
  String toString() {
    return 'FilterEditCategoryRouteArgs{key: $key, expectExperienceResponse: $expectExperienceResponse}';
  }
}

/// generated route for
/// [_i14.FilterExperienceCategoriesPage]
class FilterExperienceCategoriesRoute extends _i23.PageRouteInfo<void> {
  const FilterExperienceCategoriesRoute({List<_i23.PageRouteInfo>? children})
      : super(
          FilterExperienceCategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FilterExperienceCategoriesRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i15.FilterUpdateCategoryPage]
class FilterUpdateCategoryRoute
    extends _i23.PageRouteInfo<FilterUpdateCategoryRouteArgs> {
  FilterUpdateCategoryRoute({
    _i24.Key? key,
    required _i26.SkillResponse skillResponse,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          FilterUpdateCategoryRoute.name,
          args: FilterUpdateCategoryRouteArgs(
            key: key,
            skillResponse: skillResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'FilterUpdateCategoryRoute';

  static const _i23.PageInfo<FilterUpdateCategoryRouteArgs> page =
      _i23.PageInfo<FilterUpdateCategoryRouteArgs>(name);
}

class FilterUpdateCategoryRouteArgs {
  const FilterUpdateCategoryRouteArgs({
    this.key,
    required this.skillResponse,
  });

  final _i24.Key? key;

  final _i26.SkillResponse skillResponse;

  @override
  String toString() {
    return 'FilterUpdateCategoryRouteArgs{key: $key, skillResponse: $skillResponse}';
  }
}

/// generated route for
/// [_i16.MorePage]
class MoreRoute extends _i23.PageRouteInfo<void> {
  const MoreRoute({List<_i23.PageRouteInfo>? children})
      : super(
          MoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoreRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i17.MoreTabRouter]
class MoreTabRouter extends _i23.PageRouteInfo<void> {
  const MoreTabRouter({List<_i23.PageRouteInfo>? children})
      : super(
          MoreTabRouter.name,
          initialChildren: children,
        );

  static const String name = 'MoreTabRouter';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ServicePage]
class ServiceRoute extends _i23.PageRouteInfo<ServiceRouteArgs> {
  ServiceRoute({
    _i24.Key? key,
    _i27.StatusServiceEnum? selectedStatusOption,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          ServiceRoute.name,
          args: ServiceRouteArgs(
            key: key,
            selectedStatusOption: selectedStatusOption,
          ),
          initialChildren: children,
        );

  static const String name = 'ServiceRoute';

  static const _i23.PageInfo<ServiceRouteArgs> page =
      _i23.PageInfo<ServiceRouteArgs>(name);
}

class ServiceRouteArgs {
  const ServiceRouteArgs({
    this.key,
    this.selectedStatusOption,
  });

  final _i24.Key? key;

  final _i27.StatusServiceEnum? selectedStatusOption;

  @override
  String toString() {
    return 'ServiceRouteArgs{key: $key, selectedStatusOption: $selectedStatusOption}';
  }
}

/// generated route for
/// [_i19.UpdateCertificatePage]
class UpdateCertificateRoute
    extends _i23.PageRouteInfo<UpdateCertificateRouteArgs> {
  UpdateCertificateRoute({
    _i24.Key? key,
    required _i28.CertificateResponse certificateResponse,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          UpdateCertificateRoute.name,
          args: UpdateCertificateRouteArgs(
            key: key,
            certificateResponse: certificateResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateCertificateRoute';

  static const _i23.PageInfo<UpdateCertificateRouteArgs> page =
      _i23.PageInfo<UpdateCertificateRouteArgs>(name);
}

class UpdateCertificateRouteArgs {
  const UpdateCertificateRouteArgs({
    this.key,
    required this.certificateResponse,
  });

  final _i24.Key? key;

  final _i28.CertificateResponse certificateResponse;

  @override
  String toString() {
    return 'UpdateCertificateRouteArgs{key: $key, certificateResponse: $certificateResponse}';
  }
}

/// generated route for
/// [_i20.UpdateInformationPage]
class UpdateInformationRoute extends _i23.PageRouteInfo<void> {
  const UpdateInformationRoute({List<_i23.PageRouteInfo>? children})
      : super(
          UpdateInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateInformationRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i21.UpdateSkillPage]
class UpdateSkillRoute extends _i23.PageRouteInfo<UpdateSkillRouteArgs> {
  UpdateSkillRoute({
    _i24.Key? key,
    required _i26.SkillResponse skillResponse,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          UpdateSkillRoute.name,
          args: UpdateSkillRouteArgs(
            key: key,
            skillResponse: skillResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateSkillRoute';

  static const _i23.PageInfo<UpdateSkillRouteArgs> page =
      _i23.PageInfo<UpdateSkillRouteArgs>(name);
}

class UpdateSkillRouteArgs {
  const UpdateSkillRouteArgs({
    this.key,
    required this.skillResponse,
  });

  final _i24.Key? key;

  final _i26.SkillResponse skillResponse;

  @override
  String toString() {
    return 'UpdateSkillRouteArgs{key: $key, skillResponse: $skillResponse}';
  }
}

/// generated route for
/// [_i22.WalletPage]
class WalletRoute extends _i23.PageRouteInfo<void> {
  const WalletRoute({List<_i23.PageRouteInfo>? children})
      : super(
          WalletRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}
