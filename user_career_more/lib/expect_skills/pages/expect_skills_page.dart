import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ExpectSkillsPage extends ConsumerStatefulWidget {
  const ExpectSkillsPage({super.key});

  @override
  ConsumerState createState() => _ExpectSkillsPageState();
}

class _ExpectSkillsPageState extends ConsumerState<ExpectSkillsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
