import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AddExperiencePage extends ConsumerStatefulWidget {
  const AddExperiencePage({super.key});

  @override
  ConsumerState createState() => _AddExperiencePageState();
}

class _AddExperiencePageState extends ConsumerState<AddExperiencePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
