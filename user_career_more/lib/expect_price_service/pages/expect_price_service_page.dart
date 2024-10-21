import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dtp;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/expect_price_service/controllers/price_service_controller.dart';
import 'package:user_career_more/expect_price_service/models/service_user_response.dart';
import 'package:user_career_more/expect_price_service/models/skill_response.dart';

@RoutePage()
class ExpectPriceServicePage extends ConsumerStatefulWidget {
  const ExpectPriceServicePage({super.key});

  @override
  ConsumerState createState() => _ExpectPriceServicePageState();
}

class _ExpectPriceServicePageState extends ConsumerState<ExpectPriceServicePage> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(priceServiceControllerProvider);
    final controller = ref.watch(priceServiceControllerProvider.notifier);

    return BaseScaffold(
      backgroundColor: AppColors.white1Color,
      customAppBar: BaseAppBarView(
        title: L.more.expectListTilePrice,
      ),
      bottomView: Container(
        color: AppColors.white1Color,
        child: AppButton(
          title: L.more.addExperienceTextButton,
          onPressed: () {
            if(state.serviceId == null){
              controller.addServiceGeneral().then((value) => {
                if (value == true){
                  context.showSuccess(L.more.inforMessageSuccess),
                }
              });
            }else{
              controller.updateServiceGeneral().then((value) => {
                if (value == true){
                  context.showSuccess(L.more.inforMessageSuccess),
                }
              });
            }
          },
        ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: SeparatedColumn(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                L.more.priceService.serviceCallPrice,
                style: ref.theme.mediumTextStyle.weight(FontWeight.w600),
              ).paddingOnly(top: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFieldView.outsideBorder(
                      title: L.more.priceService.call,
                      placeholder: L.more.priceService.minute,
                      isRequired: true,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      inputType: TextInputType.number,
                      validator: (_) => (state.isEmptyTimeOnline),
                      errorText: () => L.more.errorInvalidMessage,
                      initialText: ( state.timeOnline ?? '').toString(),
                      textFieldDidChange: (text) {
                        int number = int.parse(text!);
                        controller.setTimeOnline(number);
                      },
                    ).paddingOnly(top: 12),
                  ),
                  const Gap(12),
                  Expanded(
                    child: TextFieldView.outsideBorder(
                      title: L.more.priceService.callPrice,
                      placeholder: L.more.priceService.currencyVnd,
                      isRequired: true,
                      validator: (_) => (state.isEmptyPriceOnline),
                      errorText: () => L.more.errorInvalidMessage,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      inputType: TextInputType.number,
                      initialText: ( state.priceOnline ?? '' ).toString(),
                      textFieldDidChange: (text) {
                        int number = int.parse(text!);
                        controller.setPriceOnline(number);
                      },
                    ).paddingOnly(top: 12),
                  ),
                ],
              ),
              Text(
                L.more.priceService.serviceDirectPrice,
                style: ref.theme.mediumTextStyle.weight(FontWeight.w600),
              ).paddingOnly(top: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFieldView.outsideBorder(
                      title: L.more.priceService.direct,
                      placeholder: L.more.priceService.minute,
                      isRequired: true,
                      validator: (_) => (state.isEmptyTimeOffline),
                      errorText: () => L.more.errorInvalidMessage,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      inputType: TextInputType.number,
                      initialText: (state.timeOffline ?? '').toString(),
                      textFieldDidChange: (text) {
                        int number = int.parse(text!);
                        controller.setTimeOffline(number);
                      },
                    ).paddingOnly(top: 12),
                  ),
                  const Gap(12),
                  Expanded(
                    child: TextFieldView.outsideBorder(
                      title: L.more.priceService.directPrice,
                      placeholder: L.more.priceService.currencyVnd,
                      isRequired: true,
                      validator: (_) => (state.isEmptyPriceOffline),
                      errorText: () => L.more.errorInvalidMessage,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      inputType: TextInputType.number,
                      initialText: (state.priceOffline ?? '').toString(),
                      textFieldDidChange: (text) {
                        int number = int.parse(text!);
                        controller.setPriceOffline(number);
                      },
                    ).paddingOnly(top: 12),
                  ),
                ],
              ).paddingOnly(bottom: 12),
              BaseWrapItemsSelectableView<BaseSelectableItemModel<SkillResponse>>(
                title: "Chọn kỹ năng",
                itemPickerTitle: "Chọn kỹ năng",
                textPlaceHolder: "Vui lòng Chọn",
                isRequired: true,
                items: state.skill ?? [],
                isMultiSelection: false,
                onAddNewItems: (items) {
                  state.skill?.clear();
                  state.skill?.addAll(items);
                  controller.setSkillId(items.first.data.skillId!);
                },
                onRemoveItem: (item) {
                  state.skill?.remove(item);
                  controller.setSkillId(0);
                },
                getItems: (int page) async {
                  return controller.getListSkill();
                }
              ),
              const Divider(
                color: AppColors.white3Color, thickness: 3,
              ).paddingOnly(bottom: 12),
              ...state.frames?.map((frames){
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.white1Color,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EasyRichText(
                            "${L.more.priceService.consultationTime} *",
                            defaultStyle: ref.theme.mediumTextStyle.weight(FontWeight.w600),
                            patternList: [
                              EasyRichTextPattern(
                                  targetString: "*",
                                  superScript: true,
                                  style: const TextStyle(color: Color(0xFFFF0000), fontSize: 16)
                                      .weight(FontWeight.w500),
                                  hasSpecialCharacters: true)
                            ],
                          ),
                          const Icon(
                            Icons.highlight_remove_sharp,
                            color: AppColors.black3Color,
                          ).onTapWidget(() {
                            controller.removeItemFrame(frames);
                          }),
                        ],
                      ).paddingOnly(bottom: 12),
                      Row(
                        children: [
                          Text(
                            L.more.priceService.dayOfWeek,
                            style: ref.theme.mediumTextStyle.weight(FontWeight.w600),
                          ).paddingOnly(right: 12),
                          ItemsPickerTextFieldView<BaseSelectableItemModel<WeekDayEnum>,
                              Metadata>(
                            isRequired: true,
                            enableOutSideBorder: true,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            placeholder: "Chọn ngày",
                            selectedItem: () {
                              final selectedWeekDay = WeekDayEnum.values.firstWhere(
                                    (e) => e.rawValue == frames.weekDay,
                                orElse: () => WeekDayEnum.monday,
                              );
                              return BaseSelectableItemModel<WeekDayEnum>(
                                data: selectedWeekDay,
                                id: selectedWeekDay.weekDayId,
                                name: selectedWeekDay.localizedValue,
                              );
                            },
                            onLoadItems: (page) async {
                              return WeekDayEnum.values
                                  .map((e) => BaseSelectableItemModel<WeekDayEnum>(
                                name: e.localizedValue,
                                id: e.weekDayId,
                                data: e,
                              )).toList();
                            },
                            onConfirmSelectedItem: (item) {
                              controller.setWeekDay(frames, item!.data.rawValue);
                            },
                          ).expand(),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            L.more.priceService.timeFrame,
                            style: ref.theme.mediumTextStyle.weight(FontWeight.w600),
                          ).paddingOnly(right: 12),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController()..text = frames.startTime ?? "",
                              decoration: InputDecoration(
                                hintText: "Bắt đầu",
                                hintStyle: ref.theme.mediumTextStyle.weight(FontWeight.w400),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Colors.blue),
                                ),
                              ),
                              onTap: () {
                                dtp.DatePicker.showTimePicker(
                                  context,
                                  theme: dtp.DatePickerTheme(
                                    containerHeight: 210.0,
                                    headerColor: AppColors.mainColor,
                                    backgroundColor: AppColors.white1Color,
                                    cancelStyle: ref.theme.mediumTextStyle
                                        .copyWith(color: AppColors.white1Color)
                                        .weight(FontWeight.w600),
                                    doneStyle: ref.theme.mediumTextStyle
                                        .copyWith(color: AppColors.white1Color)
                                        .weight(FontWeight.w600),
                                    itemStyle: ref.theme.mediumTextStyle,
                                  ),
                                  currentTime: DateTime.now().copyWith(hour: 8, minute: 0, second: 0),
                                  onConfirm: (time) {
                                    final formattedTime = time.clock();
                                    controller.setStartTime(frames, formattedTime!);

                                  },
                                );
                              },
                            ).paddingOnly(top: 12),
                          ),
                          const Gap(12),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController()..text = frames.endTime ?? "",
                              decoration: InputDecoration(
                                hintText: "Kết thúc",
                                hintStyle: ref.theme.mediumTextStyle.weight(FontWeight.w400),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Colors.blue),
                                ),
                              ),
                              onTap: () {
                                dtp.DatePicker.showTimePicker(
                                  context,
                                  theme: dtp.DatePickerTheme(
                                    containerHeight: 210.0,
                                    headerColor: AppColors.mainColor,
                                    backgroundColor: AppColors.white1Color,
                                    cancelStyle: ref.theme.mediumTextStyle
                                        .copyWith(color: AppColors.white1Color)
                                        .weight(FontWeight.w600),
                                    doneStyle: ref.theme.mediumTextStyle
                                        .copyWith(color: AppColors.white1Color)
                                        .weight(FontWeight.w600),
                                    itemStyle: ref.theme.mediumTextStyle,
                                  ),
                                  currentTime: DateTime.now().copyWith(hour: 12, minute: 0, second: 0),
                                  onConfirm: (time) {
                                    final formattedTime = time.clock();
                                    controller.setEndTime(frames, formattedTime!);
                                  },
                                );
                              },
                            ).paddingOnly(top: 12),
                          ),
                        ],
                      ),
                    ],
                  ).paddingAll(12.0),
                ).paddingOnly(bottom: 12);
              }).toList() ?? [],
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white1Color,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: AppColors.mainColor),
                    HSpace(8),
                    const Text(
                      "Thêm thời gian tư vấn",
                      style: TextStyle(fontSize: 18,color: AppColors.mainColor)
                    ),
                  ],
                ),
              ).onTapWidget((){controller.addItemFrame();}).paddingOnly(bottom: 12),
            ],
          ).paddingSymmetric(horizontal: 12),
        ),
      ),
    );
  }
}
