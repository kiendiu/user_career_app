import 'package:user_career_core/user_career_core.dart';

class ServiceParam extends BaseParams{
  int? page;
  int? size = 10;
  String? type;
  String? status;

  ServiceParam({this.page, this.size, this.type, this.status});

  @override
  Map<String, dynamic> buildParams(){
    return super.buildParams()
      ..addAll({
        "page": page,
        "size": size,
        "type": type,
        "status": status,
      });
  }
}