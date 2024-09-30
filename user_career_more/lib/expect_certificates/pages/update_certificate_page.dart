import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_text_field_view.dart';
import 'package:user_career_more/expect_certificates/controllers/update_certificate_controller.dart';
import 'package:user_career_more/expect_certificates/models/certificate_response.dart';

@RoutePage()
class UpdateCertificatePage extends ConsumerStatefulWidget {
  final CertificateResponse certificateResponse;
  const UpdateCertificatePage({super.key, required this.certificateResponse});

  @override
  ConsumerState createState() => _UpdateCertificatePageState();
}

class _UpdateCertificatePageState extends ConsumerState<UpdateCertificatePage>
    with ImagesPickerCompatible,
        PickerSettings,
        ImageSourceCompatible,
        FilesPickerCompatible{
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(updateCertificateControllerProvider(widget.certificateResponse));
    final controller = ref.watch(updateCertificateControllerProvider(widget.certificateResponse).notifier);
    final controllerUpload = ref.read(updateCertificateControllerProvider(widget.certificateResponse).notifier);
    return BaseScaffold(
        customAppBar: AppBar(
          title: Text(
            L.more.addExperienceTitle,
            style: const TextStyle(
              color: AppColors.white1Color,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          leading: const BackButton(color: AppColors.white1Color),
        ),
        bottomView: Container(
          color: AppColors.white1Color,
          child: AppButton(
            title: L.more.addExperienceTextButton,
            onPressed: () {
              controller.updateCertificate()
                  .then((value) => {
                if (value == true)
                  {
                    context.showSuccess(L.more.inforMessageSuccess),
                    NotificationCenter()
                        .postNotification(RawStringNotificationName('reloadListCertificate')),
                    context.maybePop(),
                  }
              });
            },
          ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldView.outsideBorder(
                  title: "Tên chứng chỉ",
                  placeholder: "Tên chứng chỉ",
                  initialText: state.certificateRequest.certificateName ?? "Tên chứng chỉ",
                  isRequired: true,
                  validator: (_) => state.certificateRequest.isCertificateNameEmpty,
                  errorText: () => L.more.errorEmpty,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  textFieldDidChange: (text){
                    controller.setName(text);
                  },
                ).paddingOnly(top: 12),
                CommonTextFieldView(
                  borderRadius: 18,
                  title: "Mô tả chứng chỉ",
                  placeholder: "Mô tả chứng chỉ",
                  initialText: state.certificateRequest.certificateDescription ?? "Mô tả chứng chỉ",
                  isRequired: true,
                  lengthLimiter: CharacterLengthLimiter(length: 100),
                  validator: (_) => state.certificateRequest.isCertificateDescriptionEmpty,
                  errorText: () => L.more.errorEmpty,
                  textFieldDidChange: (text){
                    controller.setDescription(text);
                  },
                ).paddingOnly(top: 12),
                TextFieldView.outsideBorder(
                  title: "Đường dẫn chứng chỉ",
                  placeholder: "Đường dẫn chứng chỉ",
                  isRequired: true,
                  initialText: state.certificateRequest.linkUrl ?? "Dường dẫn chứng chỉ",
                  validator: (_) => state.certificateRequest.isLinkUrlEmpty,
                  errorText: () => L.more.errorEmpty,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  textFieldDidChange: (text){
                    controller.setLinkUrl(text);
                  },
                ).paddingOnly(top: 12),
                TextButton(
                    onPressed: (){
                      context.showFixedListInteractiveSheet([
                        InteractiveListItem.icon(
                          icon: Assets.icons.icCamera.svg(width: 24, height: 24),
                          title: L.common.baseUploadAvatarView.capture,
                          onPressed: () async {
                            final image = await singlePickFromCamera();
                            if (image.isNull) return;
                            controllerUpload.setAvatar(noDeleteAvatar: true, avatarPath: "");
                            controllerUpload.updateAvatar(image!);
                            controllerUpload.uploadFile(image);
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
                            controllerUpload.setAvatar(noDeleteAvatar: true, avatarPath: "");
                            controllerUpload.updateAvatar(image!);
                            controllerUpload.uploadFile(image);
                          },
                        ),
                        InteractiveListItem.icon(
                          icon: Assets.icons.icTrash.svg(width: 24, height: 24),
                          title: L.common.baseUploadAvatarView.delete,
                          onPressed: () {
                            controllerUpload.setAvatar(noDeleteAvatar: false, avatarPath: "");
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
                    child: const Row(
                      children: [
                        Icon(
                            Icons.cloud_upload_outlined,
                            color: AppColors.mainColor
                        ),
                        Text(
                          "Tải tệp lên",
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                )
              ],
            ).paddingSymmetric(horizontal: 12)
        )
    );
  }
}
