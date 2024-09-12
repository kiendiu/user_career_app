import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/more/controllers/more_controller.dart';
import 'package:user_career_more/more/pages/views/logout_view.dart';
@RoutePage()
class MorePage extends ConsumerStatefulWidget {
  const MorePage({super.key});

  @override
  ConsumerState createState() => _MorePageState();
}

class _MorePageState extends ConsumerState<MorePage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(moreControllerProvider);
    return BaseScaffold(
      noAppBar: true,
      backgroundColor: AppColors.white3Color,
      body: Column(
        children: [
          Container(
            color: const Color(0xff196CCD),
            child: Column(
              children: [
                Row(
                    children: [
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.white4Color),
                                borderRadius: 50.0.borderAll(),
                              ),
                              child: ImageView(
                                  url: Storage.get(POSStorageKey.infoAvatarPath) ?? "",
                                  fit: BoxFit.cover,
                                  radius: 50,
                                  placeholder: Assets.icons.icAvatarDefault
                                      .svg(height: 70, width: 70)
                              ).box(h: 70, w: 70)
                          ).paddingOnly(right: 8.0),
                          Text(
                            Storage.get(POSStorageKey.infoUserNameKey) ?? "",
                            style: ref.theme.bigTextStyle
                                .copyWith(color:AppColors.white1Color,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ).expand(),
                      Stack(children: [
                        ClipOval(
                          child: Assets.icons.icBell
                              .svg(height: 24, width: 24)
                              .onTapWidget(() {
                            NotificationCenter().postNotification(
                                RawStringNotificationName("notifications"));
                          }),
                        ),
                      ])
                    ]
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: const Color(0xff0252B4)),
                      color: AppColors.white1Color,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_today, color: AppColors.main1Color).box(w: 24, h: 24),
                            const SizedBox(height: 8.0),
                            Text('Lịch tư vấn' ,style: ref.theme.defaultTextStyle),
                          ],
                        ).paddingSymmetric(vertical: 10, horizontal: 10)
                            .onTapWidget(() => context.router.push(const CalendarRoute())),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.account_balance_wallet_outlined, color: AppColors.main1Color).box(w: 24, h: 24),
                            const SizedBox(height: 8.0),
                            Text('Ví của tôi' ,style: ref.theme.defaultTextStyle),
                          ],
                        ).paddingSymmetric(vertical: 10, horizontal: 10)
                            .onTapWidget(() => context.router.push(const WalletRoute())),
                      ],
                    )
                ).paddingSymmetric(vertical: 20)
              ],
            ).paddingSymmetric(horizontal: 16.0).paddingOnly(top: 40.0),
          ),
          _buildBody(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Quản lý dịch vụ',
              style: ref.theme.bigTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.main1Color),
            ),
            trailing: TextButton(
              onPressed: () { context.router.push(const ServiceRoute());},
              child: Text('Xem tất cả',
                style: ref.theme.mediumTextStyle,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildServiceStatusButton(Icons.access_time, 'Chờ xác nhận'),
              _buildServiceStatusButton(Icons.check_circle_outline, 'Đã xác nhận'),
              _buildServiceStatusButton(Icons.speaker_notes_outlined, 'Đã diễn ra'),
              _buildServiceStatusButton(Icons.elevator_outlined, 'Hoàn thành'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('Thông tin cá nhân'),
            onTap: () { context.router.push(const UpdateInformationRoute());},
          ),
          ListTile(
            leading: const Icon(Icons.file_present_outlined),
            title: const Text('Hồ sơ chuyên gia'),
            onTap: () {context.router.push(const ExpectRoute());},
          ),
          ListTile(
            leading: const Icon(Icons.password_rounded),
            title: const Text('Thay đổi mật khẩu'),
            onTap: () {context.router.push(const ChangePasswordRoute());},
          ),
          ListTile(
            leading: Assets.icons.icLogoutIcon.svg(height: 20, width: 20),
            title: const Text('Đăng xuất'),
            onTap: () {
              context.showOverlay(const LogoutView());
            },
          ),
        ],
      ),
    ).paddingOnly(top: 10);
  }

  Widget _buildServiceStatusButton(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: AppColors.main1Color).box(w: 20, h: 20),
        const SizedBox(height: 8),
        Text(text,style: ref.theme.smallTextStyle),
      ],
    ).paddingOnly(bottom: 15);
  }
}