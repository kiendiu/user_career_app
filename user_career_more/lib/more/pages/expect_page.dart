import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_appbar.dart';

@RoutePage()
class ExpectPage extends ConsumerStatefulWidget {
  const ExpectPage({super.key});

  @override
  ConsumerState createState() => _ExpectPageState();
}

class _ExpectPageState extends ConsumerState<ExpectPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      customAppBar: CommonAppBar(
        centerTitle: true,
        titleText: "Chuyên Gia",
      ),
      backgroundColor: AppColors.white1Color,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bạn có thể nói được ngôn ngữ nào?',
              style: ref.theme.bigTextStyle.weight(FontWeight.bold),
            ).paddingOnly(top: 14, bottom: 10),
            TextField(
              readOnly: true,
              enabled: true,
              decoration: InputDecoration(
                hintText: 'Ngôn ngữ',
                hintStyle: ref.theme.defaultTextStyle,
                suffixIcon: IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined), // Đổi icon cho phù hợp
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Bo góc
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Số năm kinh nghiệm?',
              style: ref.theme.bigTextStyle.weight(FontWeight.bold),
            ).paddingOnly(bottom: 10),
            TextField(
              keyboardType: TextInputType.number, // Đặt bàn phím số
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Giới thiệu về kinh nghiệm và kỹ năng?',
              style: ref.theme.bigTextStyle.weight(FontWeight.bold),
            ).paddingOnly(bottom: 10),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Bo góc
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Divider(),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: const Text('Kinh nghiệm'),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.build_outlined),
                    title: const Text('Kỹ năng'),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.school_outlined),
                    title: const Text('Bằng cấp'),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.attach_money_outlined),
                    title: const Text('Giá dịch vụ tư vấn'),
                    onTap: () {},
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 14.0),
      ),
    );
  }
}