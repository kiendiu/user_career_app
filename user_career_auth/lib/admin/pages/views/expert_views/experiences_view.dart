import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/responses/user_detail_response.dart';
import 'package:user_career_core/user_career_core.dart';

class ExperiencesView extends ConsumerStatefulWidget {
  final List<Experience> experience;
  const ExperiencesView({super.key, required this.experience});

  @override
  ConsumerState createState() => _ExperiencesViewState();
}

class _ExperiencesViewState extends ConsumerState<ExperiencesView> {
  @override
  Widget build(BuildContext context) {
    return widget.experience.isNotEmpty
      ? ListView(
      shrinkWrap: true,
      children: widget.experience
          .map((e) => Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Công ty: ',
                      style: ref.theme.defaultTextStyle,
                    ).paddingOnly(right: 10.0),
                    Expanded(
                      child: Text(
                        e.company ?? '',
                        style: ref.theme.defaultTextStyle.weight(FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Lĩnh vực: ',
                      style: ref.theme.defaultTextStyle,
                    ).paddingOnly(right: 10.0),
                    Expanded(
                      child: Text(
                        e.categoryName ?? '',
                        style: ref.theme.defaultTextStyle.weight(FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Chức vụ: ',
                      style: ref.theme.defaultTextStyle,
                    ).paddingOnly(right: 10.0),
                    Expanded(
                      child: Text(
                        e.position ?? '',
                        style: ref.theme.defaultTextStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Thời gian: ',
                      style: ref.theme.mediumTextStyle,
                    ).paddingOnly(right: 10.0),
                    Expanded(
                      child: Text(
                        e.timeText,
                        style: ref.theme.mediumTextStyle.copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Mô tả: ',
                      style: ref.theme.mediumTextStyle,
                    ).paddingOnly(right: 10.0),
                    Expanded(
                      child: Text(
                        e.jobDescription ?? '',
                        style: ref.theme.mediumTextStyle.copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(vertical: 12, horizontal: 12),
          ).paddingOnly(top: 5),
      ).toList(),
    )
    : Builder(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.icNoPermission.svg(),
          const Text(
            "Không có kinh nghiệm nào khác!",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff242133),
            ),
          ).marginOnly(top: 16),
        ],
      );
    });
  }
}
