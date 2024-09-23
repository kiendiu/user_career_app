import 'package:user_career_core/user_career_core.dart';

class FilterGoodsResponse implements Decodable{
  int? categoryId;
  String? nameCategory;
  int? parentId;

  @override
  void decode(json) {
    categoryId = json['id'];
    nameCategory = json['name'];
    parentId = json['category_id'];
  }
}