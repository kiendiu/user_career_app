import 'package:user_career_core/user_career_core.dart';

class PosBaseListResponseModel<T extends Decodable>
    extends BaseListResponseModel<T> {
  PosBaseListResponseModel.decodeBy(super.itemHandler) : super.decodeBy();

  @override
  void decode(json) {
    super.decode(json);
    if (json == null) return;

    if (json['metadata'] != null) {
      metadata = PosMetadata()..decode(json['metadata']);
    }
  }
}

class PosMetadata extends Metadata {
  @override
  void decode(json) {
    super.decode(json);
    if(page != null) page = page! - 1;
  }
}
