import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/request/models/add_request_controller_state.dart';
import 'package:user_career_request/request/models/categories_response.dart';
import 'package:user_career_request/request/models/request.dart';
import 'package:user_career_request/request/repositories/request_repository.dart';

class AddRequestController extends AutoDisposeNotifier<AddRequestControllerState> with AlertMixin, MetadataUpdater{
  @override
  AddRequestControllerState build() {
    return AddRequestControllerState(
        selectedContactMethod: "offline",
        request: Request(contactMethod: "offline")
    );
  }

  Future<bool> addRequest() async {
    final result = await ref
        .read(requestRepositoryProvider)
        .addRequest(state.request)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  Future<bool> cancelRequest(int id) async {
    final result = await ref
        .read(requestRepositoryProvider)
        .cancelRequest(id)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  Future<List<BaseSelectableItemModel<CategoriesResponse>>> getCategories() async {
    try {
      final result = await ref
          .read(requestRepositoryProvider)
          .getCategories()
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result.map((element) {
        return BaseSelectableItemModel<CategoriesResponse>(
          data: element,
          id: element.categoryId,
          name: element.nameCategory,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  void updateSelected(String? selectedContactMethod) {
    state = state.copyWith(selectedContactMethod: selectedContactMethod);
  }

  void updateTitle(String title) {
    state = state.copyWith(request: state.request.copyWith(title: title));
  }

  void updateDescription(String description) {
    state = state.copyWith(request: state.request.copyWith(description: description));
  }

  void updateCategoryId(int categoryId) {
    state = state.copyWith(request: state.request.copyWith(categoryId: categoryId));
  }

  void updateContactMethod(String contactMethod) {
    state = state.copyWith(request: state.request.copyWith(contactMethod: contactMethod));
  }

  void updateBiddingEndDate(DateTime biddingEndDate) {
    state = state.copyWith(request: state.request.copyWith(biddingEndDate: biddingEndDate));
  }

  void updateLocationName(String locationName) {
    state = state.copyWith(request: state.request.copyWith(locationName: locationName));
  }

  void updateAddress(String address) {
    state = state.copyWith(request: state.request.copyWith(address: address));
  }

  void updateBudget(int budget) {
    state = state.copyWith(request: state.request.copyWith(budget: budget));
  }

  void updateField(List<BaseSelectableItemModel<CategoriesResponse>> field) {
    state = state.copyWith(request: state.request.copyWith(field: field));
  }
}

final addRequestControllerProvider = NotifierProvider.autoDispose<AddRequestController, AddRequestControllerState>(() {
  return AddRequestController();
});