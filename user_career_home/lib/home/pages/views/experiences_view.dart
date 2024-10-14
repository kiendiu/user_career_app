import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/home/models/expect_detail_response.dart';

class ExperiencesView extends ConsumerStatefulWidget {
  final List<Experience> experience;
  const ExperiencesView({super.key, required this.experience});

  @override
  ConsumerState createState() => _ExperiencesViewState();
}

class _ExperiencesViewState extends ConsumerState<ExperiencesView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: widget.experience
          .map((e) => Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.company ?? '',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  e.categoryName ?? '',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
                const SizedBox(height: 4),
                Text(
                  e.position ?? '',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
                const SizedBox(height: 4),
                Text(
                  e.timeText,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  e.jobDescription ?? '',
                  style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                ),
              ],
            ).paddingSymmetric(vertical: 10, horizontal: 10),
          ).paddingOnly(top: 5),
      ).toList(),
    );
  }
}
