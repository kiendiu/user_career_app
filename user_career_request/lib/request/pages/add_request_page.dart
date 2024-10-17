import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/request/controllers/add_request_controller.dart';
import 'package:user_career_request/request/models/categories_response.dart';
import 'package:user_career_request/request/models/request.dart';

@RoutePage()
class AddRequestPage extends ConsumerStatefulWidget {
  const AddRequestPage({super.key});

  @override
  ConsumerState createState() => _AddRequestPageState();
}

class _AddRequestPageState extends ConsumerState<AddRequestPage> {
  final _appBarController = BaseAppBarController();
  List<BaseSelectableItemModel<CategoriesResponse>> field = [];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addRequestControllerProvider);
    final controller = ref.read(addRequestControllerProvider.notifier);

    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: BaseAppBarView(
        title: "Thêm yêu cầu",
        controller: _appBarController,
        shouldShowLeading: true,
      ),
      bottomView: Container(
        color: AppColors.white1Color,
        child: AppButton(
          title: L.more.addExperienceTextButton,
          onPressed: () {
            controller.addRequest()
                .then((value) => {
              if (value == true)
                {
                  context.showSuccess(L.more.inforMessageSuccess),
                  NotificationCenter()
                      .postNotification(RawStringNotificationName('reloadMine')),
                  context.maybePop(),
                }
            });
          },
        ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              TextFieldView.outsideBorder(
                title: "Yêu cầu tư vấn",
                placeholder: "Bạn muốn được tư vấn gì?",
                isRequired: true,
                padding: const EdgeInsets.only(left: 14, right: 14),
                textFieldDidChange: (text){
                  controller.updateTitle(text!);
                },
              ).paddingOnly(bottom: 5.0),
              CommonTextFieldView(
                borderRadius: 18,
                title: "Chi tiết yêu cầu",
                placeholder: "Mô tả",
                isRequired: true,
                lengthLimiter: CharacterLengthLimiter(length: 100),
                textFieldDidChange: (text){
                  controller.updateDescription(text!);
                },
              ).paddingOnly(bottom: 5.0),
              BaseWrapItemsSelectableView<BaseSelectableItemModel<CategoriesResponse>>(
                  title: "Lĩnh vực",
                  itemPickerTitle: "Lĩnh vực",
                  textPlaceHolder: "Vui lòng Chọn",
                  isRequired: true,
                  items: field,
                  isMultiSelection: false,
                  onAddNewItems: (items) {
                    field.clear();
                    field.addAll(items);
                    controller.updateField(field);
                    controller.updateCategoryId(field.first.data.categoryId ?? 0);
                  },
                  onRemoveItem: (item) {
                    field.remove(item);
                    controller.updateCategoryId(0);
                  },
                  getItems: (int page) async {
                    return controller.getCategories();
                  }
              ).paddingOnly(bottom: 5.0),
              DatePickerTextFieldView(
                  title: "Ngày kết thúc",
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  onConfirmSelectTime: (date) {
                    controller.updateBiddingEndDate(date!);
                  }
              ).paddingOnly(bottom: 5.0),
              TextFieldView.outsideBorder(
                title: "Ngân sách",
                placeholder: "Giá",
                isRequired: true,
                padding: const EdgeInsets.only(left: 14, right: 14),
                inputType: TextInputType.number,
                textFieldDidChange: (text){
                  var number = int.parse(text!);
                  controller.updateBudget(number);
                },
              ).paddingOnly(bottom: 5.0),
              ...ContactMethodEnum.values.map((type) {
                return Column(
                  children: [
                    BaseCheckBox.initState(
                      isSelected: state.selectedContactMethod == type.rawValue,
                      checkBoxStyle: CheckBoxStyle.circle,
                      onTap: (value) {
                        setState(() {
                          controller.updateContactMethod(type.rawValue);
                          controller.updateSelected(type.rawValue);
                        });
                      },
                      rightWidget: Text(type.localizedValue,
                          style: ref.theme.mediumTextStyle),
                    ).paddingSymmetric(vertical: 12),
                  ],
                );
              }),
              state.selectedContactMethod == "offline"
                ? Column(
                  children: [
                    TextFieldView.outsideBorder(
                      title: "Tên địa điểm",
                      placeholder: "Tên địa điểm",
                      isRequired: true,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      inputType: TextInputType.number,
                      textFieldDidChange: (text){
                        controller.updateLocationName(text!);
                      },
                    ).paddingOnly(bottom: 5.0),
                    TextFieldView.outsideBorder(
                      title: "Địa chỉ",
                      placeholder: "Địa chỉ",
                      isRequired: true,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      textFieldDidChange: (text){
                        controller.updateAddress(text!);
                      },
                    ).paddingOnly(bottom: 5.0),
                  ],
                )
                : const SizedBox(),

            ],
          ).paddingSymmetric(horizontal: 10).makeColor(AppColors.white1Color),
        ],
      )
    );
  }
}
