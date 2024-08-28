import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

@RoutePage()
class RequestPage extends ConsumerStatefulWidget {
  const RequestPage({super.key});

  @override
  ConsumerState createState() => _RequestPageState();
}

class _RequestPageState extends ConsumerState<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Text(
        "Request Page",
        style: ref.theme.defaultTextStyle,
      ).align(Alignment.center),
    );
  }
}
