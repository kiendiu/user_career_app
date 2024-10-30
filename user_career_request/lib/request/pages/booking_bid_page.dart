import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/core/router.gm.dart';
import 'package:user_career_request/request/controllers/booking_bid_controller.dart';
import 'package:user_career_request/request/models/info_booking_bid_model.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dtp;


@RoutePage()
class BookingBidPage extends ConsumerStatefulWidget {
  final InfoBookingBidModel infoBookingBidModel;
  const BookingBidPage({super.key, required this.infoBookingBidModel});

  @override
  ConsumerState createState() => _BookingBidPageState();
}

class _BookingBidPageState extends ConsumerState<BookingBidPage> {
  List<DateTime> selectedDates = [];
  bool isSelected = false;
  final timeEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  int bookId = 0;

  @override
  Widget build(BuildContext context) {
    final bookingBidState = ref.watch(bookingBidControllerProvider(widget.infoBookingBidModel));
    final bookingBidController = ref.watch(bookingBidControllerProvider(widget.infoBookingBidModel).notifier);

    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: BaseAppBarView(
        title: "Đặt lịch hẹn",
        shouldShowLeading: false,
      ),
        bottomView: Container(
          color: AppColors.white1Color,
          child: AppButton(
            title: "Xác nhận",
            onPressed: () {
              bookingBidController.createBooking().then((value) {
                if (value.bookId != 0) {
                  bookingBidController.updateBookId(value.bookId ?? 0);
                  setState(() {
                    bookId = value.bookId ?? 0;
                  });
                  context.showSuccess("Đặt lịch thành công");
                  context.router.popUntil(
                          (route) => route.settings.name != BookingBidRoute.name);
                }
              });
            },
          ).paddingSymmetric(horizontal: 16).paddingOnly(top: 12, bottom: 40),
        ),
      body: SingleChildScrollView(
        child: Column(
          children:[
           TextFieldView.outsideBorder(
             title: "Giá dịch vụ",
             initialText: "${NumberFormat("###,###").format(bookingBidState.totalPrice)}đ",
             isDisabled: true,
           ).paddingOnly(bottom: 12, top: 12),
           bookingBidState.contactMethod == "offline"
             ? TextFieldView.outsideBorder(
                 title: "Địa chỉ",
                 initialText: bookingBidState.address,
                 isDisabled: true,
               ).paddingOnly(bottom: 12)
             : const SizedBox(),
          bookingBidState.contactMethod == "offline"
            ? TextFieldView.outsideBorder(
                title: "Tên địa điểm",
                initialText: bookingBidState.locationName,
                isDisabled: true,
              ).paddingOnly(bottom: 12)
            : const SizedBox(),
            TextFieldView.outsideBorder(
              isRequired: true,
              title: "Lời nhắn",
              initialText: bookingBidState.noteMessage,
            ).paddingOnly(bottom: 12),
            const Divider().paddingOnly(bottom: 12.0),
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                firstDate: DateTime.now(),
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
            const Divider().paddingOnly(bottom: 12.0),
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
                            bookingBidController.updateScheduleTime(date: selectedDates.first, time: time);
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
                        hintText: "Phút",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text){
                        int number = int.parse(text);
                        bookingBidController.updateDuration(number);
                      },
                    ).expand(),
                  ],
                ).paddingOnly(bottom: 10)
              ],
            ) : const SizedBox(),

          ]
        ).paddingSymmetric(horizontal: 12.0).makeColor(AppColors.white1Color)
      )
    );
  }
}
