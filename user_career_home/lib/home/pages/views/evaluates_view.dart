import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/home/models/expect_detail_response.dart';
import 'package:user_career_home/home/pages/views/star_rating_view.dart';

class EvaluatesView extends ConsumerStatefulWidget {
  final Review review;
  const EvaluatesView({super.key, required this.review});

  @override
  ConsumerState createState() => _EvaluatesViewState();
}

class _EvaluatesViewState extends ConsumerState<EvaluatesView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                widget.review.averageRating.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ).paddingOnly(right: 5),
            StarRating(rating: widget.review.averageRating ?? 0.0, sizeStar: 18),
            Text(
              '( ${widget.review.totalReview} đánh giá )',
              style: ref.theme.mediumTextStyle
                  .weight(FontWeight.w800)
                  .copyWith(color: Colors.grey),
            ).paddingOnly(left: 5),
          ],
        ).paddingSymmetric(vertical: 10).paddingOnly(left: 10).makeColor(Colors.white),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.review.evaluate?.length ?? 0,
            itemBuilder: (context, index) {
              final e = widget.review.evaluate![index];
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageView(
                        url: e.customerAvatar ?? '',
                        fit: BoxFit.cover,
                        radius: 50,
                        placeholder: Assets.icons.icAvatarDefault
                            .svg(height: 50, width: 50)
                    ).box(w: 50, h: 50).paddingSymmetric(horizontal: 10.0),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.customerName ?? '',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              StarRating(rating: (e.rating ?? 0).toDouble(), sizeStar: 18),
                              Text(
                                e.createAtString ?? '',
                                style: const TextStyle(color: Colors.grey),
                              ).paddingOnly(left: 5.0)
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            e.reviewDescription ?? '',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ).paddingOnly(top: 5);
  }
}
