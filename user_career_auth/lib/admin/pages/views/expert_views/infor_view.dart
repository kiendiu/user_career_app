import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/responses/user_detail_response.dart';
import 'package:user_career_core/user_career_core.dart';

class InforView extends ConsumerStatefulWidget {
  final Information information;
  const InforView({super.key, required this.information});

  @override
  ConsumerState createState() => _InforViewState();
}

class _InforViewState extends ConsumerState<InforView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(
          icon: Icons.language,
          label: 'Ngôn ngữ:',
          value: widget.information.language ?? "_",
        ).paddingOnly(top: 2),
        InfoRow(
          icon: Icons.history,
          label: 'Số năm kinh nghiệm:',
          value: widget.information.experienceYear.isNull
            ? "_"
            : '${widget.information.experienceYear} năm kinh nghiệm',
        ),
        InfoRow(
          icon: Icons.workspace_premium_outlined,
          label: 'Kỹ năng:',
          value: widget.information.skillDescription ?? "_",
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({super.key, 
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon, size: 30,
          color: AppColors.mainColor
        ).paddingOnly(left: 10),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ).paddingSymmetric(vertical: 10),
      ],
    ).makeColor(AppColors.white1Color).paddingOnly(bottom: 2);
  }
}
