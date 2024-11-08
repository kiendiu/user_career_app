import 'package:user_career_core/user_career_core.dart';

class CategoryModel implements Decodable, Encodable{
  int? categoryId;
  String? nameCategory;
  int? parentId;

  CategoryModel({this.categoryId, this.nameCategory, this.parentId});

  @override
  void decode(json) {
    categoryId = json['category_id'];
    nameCategory = json['name_category'];
    parentId = json['parent_id'];
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'name_category': nameCategory,
      'parent_id': parentId,
    };
  }

  CategoryModel copyWith({
    int? categoryId,
    String? nameCategory,
    int? parentId,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      nameCategory: nameCategory ?? this.nameCategory,
      parentId: parentId ?? this.parentId,
    );
  }
}

class CategoryFullModel{
  final CategoryModel categoryModel;
  CategoryModel? parentCategoryModel;

  CategoryFullModel({required this.categoryModel, this.parentCategoryModel});

  CategoryFullModel copyWith({
    CategoryModel? categoryModel,
    CategoryModel? parentCategoryModel,
  }) {
    return CategoryFullModel(
      categoryModel: categoryModel ?? this.categoryModel,
      parentCategoryModel: parentCategoryModel ?? this.parentCategoryModel,
    );
  }
}