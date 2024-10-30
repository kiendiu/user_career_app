import 'package:user_career_core/user_career_core.dart';

class WalletParams extends BaseParams{
  int? page;
  int? size;
  String? type;

  WalletParams({
    this.page,
    this.type,
  }): size = 20;


  @override
  Map<String, dynamic> buildParams() {
    return super.buildParams()
      ..addAll({
        "page": page,
        "size": size,
        "type": type,
      });
  }
}