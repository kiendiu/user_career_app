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
            color: AppColors.mainColor,
            child: Column(
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
                            const Icon(Icons.calendar_today, color: AppColors.mainColor).box(w: 24, h: 24),
                            const SizedBox(height: 8.0),
                            Text(L.more.textMyCalendar ,style: ref.theme.defaultTextStyle),
                          ],
                        ).paddingSymmetric(vertical: 10, horizontal: 10)
                            .onTapWidget(() => context.router.push(const CalendarRoute())),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.account_balance_wallet_outlined, color: AppColors.mainColor).box(w: 24, h: 24),
                            const SizedBox(height: 8.0),
                            Text(L.more.textMyWallet ,style: ref.theme.defaultTextStyle),
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
              L.more.manageServiceTitle,
              style: ref.theme.bigTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor),
            ),
            trailing: TextButton(
              onPressed: () { context.router.push(const ServiceRoute());},
              child: Text(L.more.manageServiceSeeAll,
                style: ref.theme.mediumTextStyle.copyWith(color: AppColors.mainColor),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildServiceStatusButton(Icons.access_time, L.more.manageServiceStatusWaiting),
              _buildServiceStatusButton(Icons.check_circle_outline, L.more.manageServiceStatusConfirmed),
              _buildServiceStatusButton(Icons.speaker_notes_outlined, L.more.manageServiceStatusHappened),
              _buildServiceStatusButton(Icons.elevator_outlined, L.more.manageServiceStatusDone),
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
            title: Text(L.more.inforTitle),
            onTap: () { context.router.push(const UpdateInformationRoute());},
          ),
          ListTile(
            leading: const Icon(Icons.file_present_outlined),
            title: Text(L.more.expectTitle),
            onTap: () {context.router.push(const ExpectRoute());},
          ),
          ListTile(
            leading: const Icon(Icons.password_rounded),
            title: Text(L.more.changePasswordTitle),
            onTap: () {context.router.push(const ChangePasswordRoute());},
          ),
          ListTile(
            leading: Assets.icons.icLogoutIcon.svg(height: 20, width: 20),
            title: Text(L.more.logout),
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
        Icon(icon, color: AppColors.mainColor).box(w: 20, h: 20),
        const SizedBox(height: 8),
        Text(text,style: ref.theme.smallTextStyle),
      ],
    ).paddingOnly(bottom: 15);
  }
}