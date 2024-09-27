import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ExpectPriceServicePage extends ConsumerStatefulWidget {
  const ExpectPriceServicePage({super.key});

  @override
  ConsumerState createState() => _ExpectPriceServicePageState();
}

class _ExpectPriceServicePageState extends ConsumerState<ExpectPriceServicePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
