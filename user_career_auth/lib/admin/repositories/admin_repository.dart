import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_auth/admin/models/category_model.dart';
import 'package:user_career_auth/admin/models/language_model.dart';
import 'package:user_career_auth/core/repository.dart';
import 'package:user_career_core/user_career_core.dart';

abstract interface class IAdminRepository {
  ResultFuture<BaseListResponse<CategoryModel>> getCategories();

  ResultFuture<BaseListResponse<CategoryModel>> getCategoriesParent();

  ResultFuture<bool> createCategory(CategoryModel category);

  ResultFuture<bool> updateCategory(CategoryModel category);

  ResultFuture<bool> deleteCategory(int categoryId);

  ResultFuture<BaseListResponse<LanguageModel>> getLanguages();

  ResultFuture<bool> createLanguage(LanguageModel language);

  ResultFuture<bool> updateLanguage(LanguageModel language);

  ResultFuture<bool> deleteLanguage(int languageId);
}

class AdminRepository extends AuthBaseRepository implements IAdminRepository {
  @override
  ResultFuture<BaseListResponse<CategoryModel>> getCategories() {
    return make.request(
      path: '/admin/categories',
      decoder: BaseListResponseModel.decodeBy(() => CategoryModel()),
    ).get();
  }
  @override
  ResultFuture<BaseListResponse<CategoryModel>> getCategoriesParent() {
    return make.request(
      path: '/admin/categories/parent',
      decoder: BaseListResponseModel.decodeBy(() => CategoryModel()),
    ).get();
  }

  @override
  ResultFuture<bool> deleteCategory(int categoryId) {
    return make.request(
      path: '/admin/categories/$categoryId',
      decoder: const EmptyResponse(),
    ).delete().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> createCategory(CategoryModel category) {
    return make.request(
      path: '/admin/categories',
      body: category.encode(),
      decoder:const  EmptyResponse(),
    ).post().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> updateCategory(CategoryModel category) {
    return make.request(
      path: '/admin/categories/${category.categoryId}',
      body: category.encode(),
      decoder:const  EmptyResponse(),
    ).put().map(onValue: (value) => true);
  }

  @override
  ResultFuture<BaseListResponse<LanguageModel>> getLanguages() {
    return make.request(
      path: '/admin/languages',
      decoder: BaseListResponseModel.decodeBy(() => LanguageModel()),
    ).get();
  }

  @override
  ResultFuture<bool> deleteLanguage(int languageId) {
    return make.request(
      path: '/admin/languages/$languageId',
      decoder: const EmptyResponse(),
    ).delete().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> createLanguage(LanguageModel language) {
    return make.request(
      path: '/admin/languages',
      body: language.encode(),
      decoder:const  EmptyResponse(),
    ).post().map(onValue: (value) => true);
  }

  @override
  ResultFuture<bool> updateLanguage(LanguageModel language) {
    return make.request(
      path: '/admin/languages/${language.languageId}',
      body: language.encode(),
      decoder:const  EmptyResponse(),
    ).put().map(onValue: (value) => true);
  }
}

final adminRepositoryProvider = Provider.autoDispose<IAdminRepository>((ref) {
  return AdminRepository();
});
