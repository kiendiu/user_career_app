import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/service/controllers/add_review_controler.dart';

class ReviewView extends ConsumerStatefulWidget {
  final int bookId;
  const ReviewView({super.key, required this.bookId});

  @override
  ConsumerState<ReviewView> createState() => _ReviewPopupState();
}

class _ReviewPopupState extends ConsumerState<ReviewView> with AlertMixin {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    final reviewState = ref.watch(addReviewControllerProvider);
    final reviewController = ref.read(addReviewControllerProvider.notifier);

    return PopupView(
      backgroundColor: AppColors.white1Color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _reviewQuestion(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _rating = index + 1;
                    reviewController.updateRating(_rating);
                  });
                },
                child: Icon(
                  Icons.star,
                  size: 40,
                  color: index < _rating ? Colors.yellow : Colors.grey.shade400,
                ),
              );
            }),
          ).paddingSymmetric(vertical: 12),
          TextFieldView.outsideBorder(
            title: "Đánh giá",
            isRequired: true,
            height: 50,
            validator: (_) => reviewState.isEmptyComments,
            errorText: () => "Vui lòng nhập",
            lengthLimiter: CharacterLengthLimiter(length: 100),
            textFieldDidChange: (text) {
              reviewController.updateReview(text!);
            },
            isExpanded: true,
          ).paddingOnly(bottom: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _cancelButton(),
              HSpace.h8,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.mainColor,
                ),
                child: Text("Hoàn thành",
                  style: ref.theme.defaultTextStyle.copyWith(
                    color: AppColors.white1Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )).paddingSymmetric(vertical: 17.5)
                  .center()
                  .onTapWidget(() {
                    reviewController.addReview(widget.bookId).then((value){
                      if (value) {
                        context.maybePop();
                        context.showSuccess("Đánh giá thành công");
                      }
                    });
                  },
                ),
              ).expand()
            ],
          ),
        ],
      ).paddingSymmetric(vertical: 12, horizontal: 12),
    ).marginSymmetric(horizontal: 32);
  }


  Widget _cancelButton() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.white4Color,
    ),
    child: Text(
      L.more.cancel,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.black1Color,
        fontWeight: FontWeight.w500,
      ),
    )
        .paddingSymmetric(vertical: 17.5)
        .center()
        .onTapWidget(() => context.maybePop()),
  ).expand();

  Widget _reviewQuestion() => Text(
    "Đánh giá chất lượng của cuộc hẹn!",
    style: ref.theme.defaultTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.mainColor,
    ),
    textAlign: TextAlign.center,
  ).paddingOnly(top: 12);
}
