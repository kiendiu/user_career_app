import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_appbar.dart';
import 'package:user_career_more/more/controllers/more_controller.dart';
import 'package:user_career_more/update_information/controllers/update_information_controller.dart';

@RoutePage()
class UpdateInformationPage extends ConsumerStatefulWidget {
  const UpdateInformationPage({super.key});

  @override
  ConsumerState createState() => _UpdateInformationPageState();
}

class _UpdateInformationPageState extends ConsumerState<UpdateInformationPage>
  with ImagesPickerCompatible,
      PickerSettings,
      ImageSourceCompatible,
      FilesPickerCompatible {
  @override
  Widget build(BuildContext context) {
    final informationState = ref.watch(updateInformationControllerProvider);
    return BaseScaffold(
      resizeToAvoidBottomInset: false,
      customAppBar: CommonAppBar(
        centerTitle: true,
        titleText: L.more.inforTitle,
      ),
      backgroundColor: AppColors.white3Color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAvatar(informationState.updateInformationRequest.avatar ?? "")
                  .makeColor(AppColors.white1Color)
                  .paddingSymmetric(vertical: 12),
              TextFieldView.outsideBorder(
                initialText: informationState.updateInformationRequest.username,
                textFieldDidChange: (textName) {
                  ref.read(updateInformationControllerProvider.notifier)
                      .setName(textName!);
                },
                title: L.more.inforTextFieldTitleName,
                placeholder: L.more.inforTextFieldPlaceholderName,
                padding: const EdgeInsets.only(left: 14, right: 14),
              ).paddingOnly(bottom: 10.0),
              TextFieldView.outsideBorder(
                initialText: informationState.updateInformationRequest.email,
                textFieldDidChange: (textName) {
                  ref.read(updateInformationControllerProvider.notifier)
                      .setEmail(textName!);
                },
                title: L.more.inforTextFieldTitleEmail,
                placeholder: L.more.inforTextFieldPlaceholderEmail,
                padding: const EdgeInsets.only(left: 14, right: 14),
              ).paddingOnly(bottom: 10.0),
              TextFieldView.outsideBorder(
                initialText: informationState.updateInformationRequest.phone,
                textFieldDidChange: (textName) {
                  ref.read(updateInformationControllerProvider.notifier)
                      .setPhone(textName!);
                },
                title: L.more.inforTextFieldTitlePhone,
                placeholder: L.more.inforTextFieldTitlePhone,
                padding: const EdgeInsets.only(left: 14, right: 14),
              ).paddingOnly(bottom: 10.0),
              TextFieldView.outsideBorder(
                initialText: informationState.updateInformationRequest.address,
                textFieldDidChange: (textName) {
                  ref.read(updateInformationControllerProvider.notifier)
                      .setAddress(textName!);
                },
                title: L.more.inforTextFieldTitleAddress,
                placeholder: L.more.inforTextFieldPlaceholderAddress,
                padding: const EdgeInsets.only(left: 14, right: 14),
              ).paddingOnly(bottom: 10.0),
            ],
          ).paddingSymmetric(horizontal: 14)
              .makeColor(AppColors.white1Color),
          Container(
            color: AppColors.white1Color,
            child: AppButton(
              isEnabled: true,
              title: L.more.inforTextButton,
              onPressed: () {
                ref.read(updateInformationControllerProvider.notifier)
                    .updateInfo()
                    .then((value) => {
                  if (value == true)
                    {
                      context.showSuccess(L.more.inforMessageSuccess),
                      ref.invalidate(moreControllerProvider),
                    }
                });
              },
            ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
          )
        ],
      ),
    );
  }

  Widget _buildAvatar(String urlAvatar) {
    final updateInformationState =
    ref.watch(updateInformationControllerProvider);

    return InkWell(
        onTap: () {
          context.showFixedListInteractiveSheet([
            InteractiveListItem.icon(
              icon: Assets.icons.icCamera.svg(width: 24, height: 24),
              title: L.common.baseUploadAvatarView.capture,
              onPressed: () async {
                final image = await singlePickFromCamera();
                if (image.isNull) return;
                ref.read(updateInformationControllerProvider.notifier)
                    .setAvatar(noDeleteAvatar: true, avatarPath: "");
                ref.read(updateInformationControllerProvider.notifier)
                    .updateAvatar(image!);
                ref.read(updateInformationControllerProvider.notifier)
                    .uploadFile(image);
              },
            ),
            InteractiveListItem.icon(
              icon: Assets.icons.icPicture.svg(width: 24, height: 24),
              title: L.common.baseUploadAvatarView.pickImage,
              onPressed: () async {
                final image = await singlePickFromGallery(
                  requestType: RequestType.image,
                );
                if (image.isNull) return;
                ref.read(updateInformationControllerProvider.notifier)
                    .setAvatar(noDeleteAvatar: true, avatarPath: "");

                ref.read(updateInformationControllerProvider.notifier)
                    .updateAvatar(image!);
                ref.read(updateInformationControllerProvider.notifier)
                    .uploadFile(image);
              },
            ),
            InteractiveListItem.icon(
              icon: Assets.icons.icTrash.svg(width: 24, height: 24),
              title: L.common.baseUploadAvatarView.delete,
              onPressed: () {
                ref.invalidate(updateInformationControllerProvider);
                ref.read(updateInformationControllerProvider.notifier)
                    .setAvatar(noDeleteAvatar: false, avatarPath: "");
              },
            ),
          ], itemBuilder: (_, item) {
            return SizedBox(
                child: Row(
                  children: [
                    item.icon,
                    Text(item.title,
                        style: ref.theme.defaultTextStyle.textColor(
                            item.title == L.common.baseUploadAvatarView.delete
                                ? AppColors.errorColor
                                : AppColors.black1Color))
                        .marginOnly(left: 16),
                  ],
                )).marginSymmetric(horizontal: 16, vertical: 16);
          }, config: (
          isFloating: true,
          canShowIndicator: true,
          canSwipeToDismiss: true,
          ));
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white4Color),
                borderRadius: 50.0.borderAll(),
              ),
                child: updateInformationState.noDeleteAvatar == true
                    ? ref
                    .read(updateInformationControllerProvider.notifier)
                    .checkNewAvatar()
                    ? _buildNewAvatar
                    : ImageView(
                    url: urlAvatar,
                    fit: BoxFit.cover,
                    radius: 50,
                    placeholder: Assets.icons.icAvatarDefault
                        .svg(height: 100, width: 100))
                    .box(h: 100, w: 100)
                    : _buildNewAvatar),
            Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: 16.0.borderAll(),
                    color: AppColors.main1Color,
                  ),
                  alignment: Alignment.center,
                  height: 32,
                  width: 32,
                  child: const Icon(
                    Icons.add,
                    color: AppColors.white1Color,
                  ),
                ))
          ],
        ));
  }
  Widget get _buildNewAvatar {
    final newAvatar = ref.watch(updateInformationControllerProvider).newAvatar;
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: AnimatedCrossFade(
        firstChild: Assets.icons.icAvatarDefault.svg(height: 100, width: 100),
        secondChild: Visibility(
          visible: newAvatar?.isLocalFile == true,
          replacement: ImageView(url: newAvatar?.fullUrl ?? ''),
          child: Image.file(newAvatar?.file ?? File(''), fit: BoxFit.cover),
        ).squareBox(edgeSize: 100),
        duration: kThemeAnimationDuration,
        crossFadeState: newAvatar?.file == null
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
      ),
    );
  }
}