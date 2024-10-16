import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/request/models/general_controller_state.dart';
import 'package:user_career_request/request/models/request_model.dart';
import 'package:user_career_request/request/repositories/request_repository.dart';

class GeneralController extends AutoDisposeNotifier<GeneralControllerState>
    with AlertMixin, MetadataUpdater {
  @override
  GeneralControllerState build() {
    return GeneralControllerState();
  }

  Future<List<RequestModel>> getListExpects(int page) async {
    try {
      final result = await ref
          .read(requestRepositoryProvider)
          .getListGeneral(GeneralParams(
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

final generalControllerProvider = NotifierProvider.autoDispose<GeneralController, GeneralControllerState>(() {
  return GeneralController();
});