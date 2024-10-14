import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/common/career_storage_key.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/home/models/expect_response.dart';
import 'package:user_career_home/home/repositories/home_repository.dart';

class HomeController extends AutoDisposeNotifier<HomeControllerState>
    with AlertMixin, MetadataUpdater{
  @override
  HomeControllerState build() {
    return HomeControllerState();
  }

  Future<List<ExpectResponse>> getListExpects(int page) async {
    try {
      final result = await ref
        .read(homeRepositoryProvider)
        .getListExpects(HomeParams(
            page: page + 1,
            searchText: state.searchText,
            categoryId: state.categoryId
          )
        )
        .showErrorBy(this)
        .updateMetadataBy(this)
        .map(onValue: (value) => value?.items ?? [])
        .mapToValueOr(defaultValue: []).asFuture();
      return result;
    } catch (e) {
      return [];
    }
  }

  void setSearchText(String? text){
    state = state.copyWith(searchText: text);
  }

  void setCategoryId(int? id){
    state = state.copyWith(categoryId: id);
  }
}

final homeControllerProvider = NotifierProvider.autoDispose<HomeController, HomeControllerState>(() {
  return HomeController();
});

class HomeControllerState{
  String? searchText;
  int? categoryId;

  HomeControllerState({
    this.searchText,
    this.categoryId
  });

  HomeControllerState copyWith({
    String? searchText,
    int? categoryId
  }){
    return HomeControllerState(
      searchText: searchText ?? this.searchText,
      categoryId: categoryId ?? this.categoryId
    );
  }
}

class HomeParams extends BaseParams{
  int? page;
  int? size;
  String? searchText;
  int? categoryId;
  int? excludeUserId;

  HomeParams(
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