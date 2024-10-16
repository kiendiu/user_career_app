import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';

class GeneralControllerState {
  String? searchText;
  int? categoryId;

  GeneralControllerState({
    this.searchText,
    this.categoryId
  });

  GeneralControllerState copyWith({
    String? searchText,
    int? categoryId
  }){
    return GeneralControllerState(
        searchText: searchText ?? this.searchText,
        categoryId: categoryId ?? this.categoryId
    );
  }
}

class GeneralParams extends BaseParams{
  int? page;
  int? size;
  String? searchText;
  int? categoryId;
  int? excludeUserId;

  GeneralParams(
      {
        this.page,
        this.categoryId,
        this.searchText
      }
      ): size = 10 , excludeUserId = Storage.get(POSStorageKey.userId);

  @override
  Map<String, dynamic> buildParams() {
    return super.buildParams()
      ..addAll({
        "page": page,
        "size": size,
        "category_id": categoryId,
        "search_text": searchText ?? "",
        "exclude_user_id": excludeUserId
      });
  }
}