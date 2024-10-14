import 'package:user_career_core/user_career_core.dart';

class FilterResponse implements Decodable{
  int? categoryId;
  String? nameCategory;
  int? parentId;

  @override
  void decode(json) {
    categoryId = json['category_id'];
    nameCategory = json['name_category'];
    parentId = json['parent_id'];
  }
}