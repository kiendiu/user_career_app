import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/controllers/expect_controller.dart';
import 'package:user_career_more/more/models/language_model.dart';

class LanguagePickerView extends ConsumerStatefulWidget {
  final Set<LanguageModel> languages;
  final ValueChanged<Set<LanguageModel>> onSelectionChanged;
  final Set<LanguageModel> languagesLocal;

  const LanguagePickerView({super.key,
    required this.languages,
    required this.onSelectionChanged,
    required this.languagesLocal
  });

  @override
  ConsumerState createState() => _LanguagePickerViewState();
}

class _LanguagePickerViewState extends ConsumerState<LanguagePickerView>{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 500),
          child: ListView.builder(
            itemCount: widget.languages.length,
            itemBuilder: (context, index) {
              final language = widget.languages.elementAt(index);
              return CheckboxListTile(
                title: Text(language.nameLanguage ?? ''),
                value: widget.languagesLocal.contains(language),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      widget.languagesLocal.add(language);
                    } else {
                      widget.languagesLocal.remove(language);
                    }
                    widget.onSelectionChanged(widget.languagesLocal);
                  });
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton.custom(
              title: "Hủy bỏ",
              onPressed: () {
                widget.onSelectionChanged({});
                ref.invalidate(expectControllerProvider);
                context.maybePop();
              },
              titleTextStyle: const TextStyle(
                color: AppColors.black1Color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              color: AppColors.white4Color,
            ).marginOnly(right: 8).expand(),
            AppButton(
              title: "Áp dụng",
              onPressed: () {
                widget.onSelectionChanged(widget.languagesLocal);
                context.maybePop();
              },
            ).expand(),
          ],
        ).paddingSymmetric(horizontal: 14, vertical: 8)
      ],
    );
  }
}