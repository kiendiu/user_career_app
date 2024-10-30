import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/booking/models/info_booking_model.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dtp;
import 'package:user_career_home/booking/models/payment_request.dart';
import 'package:user_career_home/core/router.gm.dart';
import '../controllers/booking_controller.dart';

@RoutePage()
class BookingPage extends ConsumerStatefulWidget {
  final InfoBookingModel? infoBookingModel;
  const BookingPage({super.key, this.infoBookingModel});

  @override
  ConsumerState createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  final _appBarController = BaseAppBarController();
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  List<DateTime> selectedDates = [];
  bool isSelected = false;
  final timeEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  int bookId = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentIndex < 3) {
      setState(() {
        _currentIndex++;
      });
      _pageController.jumpToPage(_currentIndex);
    }
  }

  void _onPrevious() {
    if (_currentIndex > 0) {
      if(_currentIndex == 3){
        setState(() {
          _currentIndex = _currentIndex -2;
        });
      }else{
        setState(() {
          _currentIndex--;
        });
      }
      _pageController.jumpToPage(_currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingControllerProvider);
    final bookingController = ref.read(bookingControllerProvider.notifier);

    return BaseScaffold(
      customAppBar: BaseAppBarView(
        title: "Danh sách chuyên gia",
        controller: _appBarController,
        shouldShowLeading: true,
      ),
      backgroundColor: AppColors.white3Color,
      bottomView: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton.custom(
            title: "Quay lại",
            onPressed: () {
              if(_currentIndex == 2 && bookId != 0){
                bookingController.deleteBooking(bookId).then((value) {
                  if(value){
                    setState(() {
                      bookId = 0;
                    });
                  }
                });
              }
              _onPrevious();
            },
            titleTextStyle: const TextStyle(
              color: AppColors.black1Color,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            color: AppColors.white4Color,
          ).marginOnly(right: 8).expand(),
          AppButton(
            title: "Tiếp tục",
            onPressed: () {
              _onNext();
              if(_currentIndex == 2) {
                if(bookId == 0){
                  bookingController.updateServiceId(widget.infoBookingModel?.serviceId ?? 0);
                  bookingController.updateExpertId(widget.infoBookingModel?.expertId ?? 0);
                  bookingController.updateContactMethod(widget.infoBookingModel?.contactMethod ?? "");
                  bookingController.updateTotalPrice(
                      (widget.infoBookingModel?.price!.toDouble() ?? 0 ) * (bookingState.duration ?? 0) /( widget.infoBookingModel?.time ?? 1)
                  );
                  bookingController.createBooking().then((value) {
                    if(value.bookId != 0) {
                      bookingController.updateBookId(value.bookId ?? 0);
                      setState(() {
                        bookId = value.bookId ?? 0;
                      });
                    }
                  });
                }
              }
              if(_currentIndex == 3){
                bookingController.createPayment(PaymentRequest(
                  bookId: bookId,
                  expertId: bookingState.expertId,
                  cost: (bookingState.totalPrice ?? 0).toInt(),
                  methodPayment: "Bank"
                )).then((value) {
                  if(value){
                    context.router.popUntil(
                            (route) => route.settings.name != BookingRoute.name);
                    context.showSuccess("Thanh toán thành công");
                  }else{
                    context.showOverlay(
                      BaseConfirmPopupView.custom(
                        title: "Thanh toán thất bại",
                        message: "Số dư của bạn không đủ? Bạn có thể thanh toán sau hoặc hủy lịch hẹn.",
                        buttons: [
                          ConfirmPopupViewButton(
                            title: "Đồng ý",
                            titleColor: AppColors.white1Color,
                            background: AppColors.mainColor,
                            callback: () {
                              context.maybePop().then((value) {
                                context.router.popUntil(
                                        (route) => route.settings.name != BookingRoute.name);
                              });

                            },
                          ),
                          ConfirmPopupViewButton(
                            title: "Hủy",
                            titleColor: AppColors.black1Color,
                            background: AppColors.white4Color,
                            callback: () {
                              bookingController.deleteBooking(bookId).then((value) {
                                if(value){
                                  context.showSuccess("Hủy lịch hẹn thành công");
                                  context.router.popUntil(
                                          (route) => route.settings.name != BookingRoute.name);
                                }
                              });
                            },
                          ),
                        ],
                      )
                    );
                  }
                });
              }
            },
          ).expand(),
        ],
      ).paddingSymmetric(horizontal: 15, vertical: 15).makeColor(AppColors.white1Color),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(5),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StepperComponent(
                    currentIndex: _currentIndex,
                    index: 0,
                  ),
                  StepperComponent(
                    currentIndex: _currentIndex,
                    index: 1,
                  ),
                  StepperComponent(
                    currentIndex: _currentIndex,
                    index: 2,
                    isLast: true,
                  ),
                ],
              ).paddingSymmetric(horizontal: 20.0),
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text("Thông tin",),
                    Text("Thời gian",),
                    Text("Thanh toán",),
                  ]
              )
            ],
          ).paddingSymmetric(horizontal: 15, vertical: 15).makeColor(AppColors.white1Color),
          const Gap(5),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Thông tin liên hệ (*)",
                        style: ref.theme.defaultTextStyle.weight(FontWeight.w600)
                      ).paddingSymmetric(vertical: 12),
                      TextFieldView.outsideBorder(
                        title: "Họ tên",
                        initialText: Storage.get(POSStorageKey.infoUserNameKey),
                        isDisabled: true,
                      ).paddingOnly(bottom: 12),
                      TextFieldView.outsideBorder(
                        title: "Số điện thoại",
                        initialText: Storage.get(POSStorageKey.infoPhoneKey),
                        isDisabled: true,
                      ).paddingOnly(bottom: 12),
                      TextFieldView.outsideBorder(
                        title: "Giá dịch vụ",
                        initialText: "${NumberFormat("###,###").format(widget.infoBookingModel?.price)}đ",
                        isDisabled: true,
                      ).paddingOnly(bottom: 12),
                      TextFieldView.outsideBorder(
                        isRequired: true,
                        title: "Lời nhắn",
                        placeholder: "Nhập lời nhắn",
                        validator: (_) => bookingState.isEmptyMessage,
                        errorText: () => L.more.errorEmpty,
                        textFieldDidChange: (text) {
                          bookingController.updateNoteMessage(text!);
                        },
                      ).paddingOnly(bottom: 12),
                      widget.infoBookingModel?.contactMethod == "offline"
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(color: Colors.black26, thickness: 1),
                            Text(
                              "Thông tin địa điểm (*)",
                              style: ref.theme.defaultTextStyle.weight(FontWeight.w600)
                            ).paddingSymmetric(vertical: 12),
                            TextFieldView.outsideBorder(
                              isRequired: true,
                              title: "Tên địa điểm",
                              placeholder: "Nhập tên địa điểm",
                              validator: (_) => bookingState.isEmptyLocation,
                              errorText: () => L.more.errorEmpty,
                              textFieldDidChange: (text) {
                                bookingController.updateLocationName(text!);
                              },
                            ).paddingOnly(bottom: 12),
                            TextFieldView.outsideBorder(
                              isRequired: true,
                              title: "Địa chỉ",
                              placeholder: "Nhập địa chỉ",
                              validator: (_) => bookingState.isEmptyAddress,
                              errorText: () => L.more.errorEmpty,
                              textFieldDidChange: (text) {
                                bookingController.updateAddress(text!);
                              },
                            ).paddingOnly(bottom: 12),
                          ],
                        )
                        : const SizedBox(),
                    ]
                  ).paddingSymmetric(horizontal: 12).makeColor(AppColors.white1Color),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.single,
                          lastDate: DateTime.now().add(const Duration(days: 0)),
                          rangeBidirectional: true,
                          centerAlignModePicker: true,
                          selectedDayHighlightColor: AppColors.main1Color,
                          selectedRangeHighlightColor:
                          const Color(0xFF6777EF).withOpacity(0.2),
                          weekdayLabels: ["CN", "T2", "T3", "T4", "T5", "T6", "T7"],
                          controlsTextStyle:
                          ref.theme.defaultTextStyle.weight(FontWeight.w600),
                          disableMonthPicker: true,
                          disableModePicker: true,
                          modePickerTextHandler: (
                              {bool? isMonthPicker, DateTime? monthDate}) {
                            final date = monthDate ?? DateTime.now();
                            return "Tháng ${date.month}, ${date.year}";
                          },
                        ),
                        value: selectedDates,
                        onValueChanged: (dates) {
                          setState(() {
                            if(dates.isEmpty) {
                              isSelected = false;
                            }
                            isSelected = true;
                          });
                          selectedDates = dates;
                        },
                      ).box(h: 280),
                      const Divider(color: Colors.grey, thickness: 1,),
                      const Gap(5),
                      isSelected
                        ? Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Thời gian bắt đầu:",
                                  style: ref.theme.mediumTextStyle.weight(FontWeight.w600)
                                ).paddingOnly(right: 10),
                                TextField(
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  controller: dateEditingController,
                                  decoration: InputDecoration(
                                    hintText: "Bắt đầu",
                                    hintStyle: ref.theme.mediumTextStyle.weight(FontWeight.w400),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(color: Colors.grey.shade300),  // Set border color to red
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
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
                                        setState(() {
                                          dateEditingController.text = formattedTime!;
                                        });
                                        bookingController.updateScheduleTime(date: selectedDates.first, time: time);
                                      },
                                    );
                                  },
                                ).expand(),
                              ],
                            ).paddingOnly(bottom: 10),
                            Row(
                              children: [
                                Text(
                                    "Thời gian dự kiến:",
                                    style: ref.theme.mediumTextStyle.weight(FontWeight.w600)
                                ).paddingOnly(right: 10),
                                TextField(
                                  textAlign: TextAlign.center,
                                  controller: timeEditingController,
                                  decoration: InputDecoration(
                                    hintText: "Thời gian dự kiến",
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide(color: Colors.grey.shade300),  // Set border color to red
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,  // Set keyboard type to number
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,  // Allow only digits
                                  ],
                                  onChanged: (text){
                                    int number = int.parse(text);
                                    bookingController.updateDuration(number);
                                  },
                                ).expand(),
                                SizedBox(
                                  width: 80,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: "Phút",
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      hintStyle: ref.theme.mediumTextStyle.copyWith(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                      ),
                                    ),
                                  ),
                                ).paddingOnly(left: 10)
                              ],
                            ).paddingOnly(bottom: 10)
                          ],
                        )
                        : const SizedBox(),
                    ]
                  ).paddingSymmetric(horizontal: 12).makeColor(AppColors.white1Color),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Phương thức liên hệ",
                            style: ref.theme.bigTextStyle,
                          ),
                          Text(
                            widget.infoBookingModel?.contactMethod == "offline"
                              ? "Trực tiếp"
                              : "Gọi điện",
                            style: ref.theme.bigTextStyle,
                          )
                        ],
                      ).paddingOnly(bottom: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Giá ${widget.infoBookingModel?.time} phút",
                            style: ref.theme.bigTextStyle,
                          ),
                          Text(
                            "${widget.infoBookingModel?.price} VND",
                            style: ref.theme.bigTextStyle,
                          )
                        ],
                      ).paddingOnly(bottom: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thời gian tư vấn",
                            style: ref.theme.bigTextStyle,
                          ),
                          Text(
                            "${bookingState.duration} phút",
                            style: ref.theme.bigTextStyle,
                          )
                        ],
                      ).paddingOnly(bottom: 20),
                      const Divider(color: Colors.grey, thickness: 1,).paddingOnly(bottom: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tổng cộng",
                            style: ref.theme.bigTextStyle,
                          ),
                          Text(
                            bookingState.totalPrice.toString(),
                            style: ref.theme.bigTextStyle,
                          )
                        ],
                      ).paddingOnly(bottom: 20)
                    ]
                  ).paddingSymmetric(horizontal: 16).makeColor(AppColors.white1Color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StepperComponent extends StatelessWidget {
  final int index;
  final int currentIndex;
  final bool isLast;

  const StepperComponent({
    super.key,
    required this.currentIndex,
    required this.index,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isCompleted = index < currentIndex;

    return isLast
      ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: isCompleted || index == currentIndex
                  ? Colors.blue
                  : Colors.transparent,
              border: Border.all(
                color: isCompleted
                    ? Colors.blue
                    : Colors.black12,
              ),
            ),
            child: Center(
                child: Text('${index + 1}',
                style: const TextStyle(color: Colors.white))),
          ),
          Container(
            height: 2,
            color: isCompleted ? Colors.blue : Colors.black12,
          ),
        ],
      )
      : Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: isCompleted || index == currentIndex ? Colors.blue : Colors.transparent,
                  border: Border.all(
                    color: isCompleted ? Colors.blue : Colors.black12,
                  ),
                ),
                child: Center(child: Text('${index + 1}', style: const TextStyle(color: Colors.white))),
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: isCompleted ? Colors.blue : Colors.black12,
                ),
              ),
            ],
          ),
    );
  }
}