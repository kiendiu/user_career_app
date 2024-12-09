import 'dart:io';

import 'package:user_career/router/app_router.dart';
import 'package:user_career_auth/core/module.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/utils/app_refresh_token_request_detector.dart';
import 'package:user_career_core/utils/app_refresh_token_service.dart';
import 'package:user_career_home/core/module.dart';
import 'package:user_career_message/core/module.dart';
import 'package:user_career_more/core/module.dart';
import 'package:user_career_request/core/module.dart';
import 'package:user_career_user/core/module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'module.dart';

Future<void> saveIpAddress() async {
  String? ipAddress = await getIpAddress();
  if (ipAddress != null) {
    Storage.save(POSStorageKey.ipAddressKey, ipAddress);
  }
}


Future<String?> getIpAddress() async {
  List<NetworkInterface> interfaces = await NetworkInterface.list();
  for (var interface in interfaces) {
    for (var address in interface.addresses) {
      if (address.type == InternetAddressType.IPv4) {
        return address.address;
      }
    }
  }
  return null;
}

void createApp(Env env) {
  WidgetsFlutterBinding.ensureInitialized();
  var pageModules = <AutoRoutePageModule>[
    HomeModule(env),
    RequestModule(env),
    //MessageModule(env),
    MoreModule(env),
  ];

  App(
      name: "KMAD User Career App",
      module: UserCareerMainModule(env, subModules: [
        ...pageModules,
        CoreModule(env),
        AuthModule(env),
        FileModule(env),
        UserModule(env),
      ]),
      dependencies: AppDependencies(() async {
        get.registerSingleton<RootStackRouter>(AppRouter());
        get.registerSingleton<RefreshTokenRequestDetector>(
            AppRefreshTokenRequestDetector());
        get.registerSingleton<IRefreshTokenService>(AppRefreshTokenService());
        get.registerSingleton<ServiceUnavailableHandler>(
            AppServiceUnavailableHandler());
        get.registerSingleton<CommonErrorTransformable>(
            AppCommonErrorConverter());
      }),
      initializeBeforeAppAvailable: AppInitializer(
            () async {
          DateTimeUtils.setSupportedLocaleMessages();

          // await FirebaseNotificationService()
          //     .handleNotificationBy(AppNotificationHandler())
          //     .start();
          //
          // await FirebaseNotificationService()
          //     .initializeTerminatedNotification();

          await AuthManager.init();
          await Storage.init("kmad.career.user");

          await Future.wait([
            setLocaleIdentifier('vi_VN'),
          ]);
        },
      ),
      initializeAfterAppAvailable: AppInitializer(() async {}),
      root: AdminPOSApp(
        pageModules: pageModules,
      )).run();
}

class AdminPOSApp extends ConsumerStatefulWidget {
  final List<AutoRoutePageModule> pageModules;

  const AdminPOSApp({super.key, required this.pageModules});

  @override
  ConsumerState<AdminPOSApp> createState() => _AskanyAppState();
}

class _AskanyAppState extends ConsumerState<AdminPOSApp>
    with
        GlobalThemePlugin,
        FirebaseNotificationGetMessageFromTerminatedStateMixin {
  late MainRoute mainRoute;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mainRoute = MainRoute(
      modules: widget.pageModules,
      bottomNavigationBuilder: (modules, router) {
        return AppBottomNavigationBar(modules: modules, router: router);
      },
    );

    NotificationCenter().addObserver(
        RawStringNotificationName("open_main_route"), callback: (_) {
      appRouter.replaceAll([mainRoute]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        overrides: [],
        observers: [TalkerRiverpodObserver(talker: talker)],
        child: RefreshConfiguration(
          headerTriggerDistance: 35,
          hideFooterWhenNotFull: false,
          enableRefreshVibrate: false,
          skipCanRefresh: true,
          maxOverScrollExtent: 50,
          footerTriggerDistance: -15,
          child: InteractiveSheetConfiguration(
              titleTextStyle: const TextStyle(),
              backgroundColor: Colors.white,
              child: GlobalThemeConfiguration.defaultTheme(
                  child: Portal(
                    child: ToastificationWrapper(
                      config: ToastificationConfig(
                        marginBuilder: (alignment) {
                          return const EdgeInsets.only(top: 0);
                        },
                      ),
                      child: MaterialApp.router(
                        theme: Theme.of(context).copyWith(
                            textTheme: GoogleFonts.robotoTextTheme(),
                            appBarTheme: AppBarTheme(
                                iconTheme: IconTheme.of(context)
                                    .copyWith(color: Colors.white),
                                titleTextStyle: Theme.of(context)
                                    .appBarTheme
                                    .titleTextStyle
                                    ?.copyWith(color: Colors.white))),
                        key: globalKey,
                        debugShowCheckedModeBanner: false,
                        routerConfig: appRouter.config(
                            navigatorObservers: () => [
                              TalkerRouteObserver(talker),
                            ],
                            deepLinkBuilder: (_) => DeepLink([mainRoute])),
                        builder: (context, child) {
                          ErrorWidget.builder = (details) => CustomErrorPage(
                            errorDetails: details,
                            onBack: () {},
                          );
                          return OverlayRootBuilderWidget(
                              builder: (context, ref) => ResponsiveBreakpoints(
                                  child: child!,
                                  breakpoints: [
                                    const Breakpoint(
                                        start: 0, end: 450, name: MOBILE),
                                    const Breakpoint(
                                        start: 451, end: 800, name: TABLET),
                                  ]));
                        },
                      ),
                    ),
                  )).copyWith(
                  baseScaffoldBackgroundColor: Colors.white,
                  mainColor: const Color(0xFF0089D6),
                  secondaryColor: const Color(0xFF85AFF8),
                  focusBorderTextFieldColor: const Color(0xFF85AFF8),
                  textFieldBorderRadius: 16,
                  itemPickerConfirmTextStyle: const TextStyle(
                      color: Color(0xFF0089D6),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  tableViewCenterIndicator: Transform.scale(
                    scale: 3,
                    child: Assets.jsons.wormLoading.lottie(
                        repeat: true,
                        frameRate: const FrameRate(120),
                        height: 40,
                        width: 40),
                  ),
                  tableViewLoadIndicator: Transform.scale(
                    scale: 3,
                    child: Assets.jsons.wormLoading.lottie(
                        repeat: true,
                        frameRate: const FrameRate(120),
                        height: 30,
                        width: 30),
                  ),
                  loadingIndicator: Center(
                    child: Container(
                        height: 60,
                        width: 60,
                        decoration: const ShapeDecoration(
                            shape: CircleBorder(), color: Colors.white),
                        child: Transform.scale(
                          scale: 2,
                          child: Assets.jsons.wormLoading.lottie(
                              height: 60,
                              width: 60,
                              repeat: true,
                              frameRate: const FrameRate(120)),
                        )),
                  ))),
        ));
  }
}
