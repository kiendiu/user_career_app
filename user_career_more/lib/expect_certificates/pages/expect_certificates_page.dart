import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

@RoutePage()
class ExpectCertificatesPage extends ConsumerStatefulWidget {
  const ExpectCertificatesPage({super.key});

  @override
  ConsumerState createState() => _ExpectCertificatesPageState();
}

class _ExpectCertificatesPageState
    extends ConsumerState<ExpectCertificatesPage> {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Container(),
    );
  }
}
