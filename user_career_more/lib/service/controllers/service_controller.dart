import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/calendar/models/user_expect_enum.dart';
import 'package:user_career_more/service/controllers/service_item_controller.dart';
import 'package:user_career_more/service/models/service_controller_state.dart';
import 'package:user_career_more/service/models/service_model.dart';
import 'package:user_career_more/service/models/service_param.dart';
import 'package:user_career_more/service/models/status_service_enum.dart';
import 'package:user_career_more/service/repositories/service_repository.dart';

class ServiceController extends AutoDisposeFamilyNotifier<ServiceControllerState, StatusServiceEnum?>
  with AlertMixin, MetadataUpdater{
  @override
  ServiceControllerState build(StatusServiceEnum? arg) {
    return ServiceControllerState(
      typeSelected: UserExpectEnum.allType,
      statusSelected: arg ?? StatusServiceEnum.pending
    );
  }

  Future<List<ServiceModel>> getListServices(int page) async{
    try {
      final result = await ref
          .read(serviceRepositoryProvider)
          .getListServices(ServiceParam(
            page: page +1,
            size: 10,
            type: state.typeSelected?.rawValue,
            status: state.statusSelected?.rawValue
          ))
          .showErrorBy(this)
          .updateMetadataBy(this)
          .mapToValueOr(defaultValue: ListServiceData<ServiceModel>())
          .asFuture();
      ref.read(commonQtyControllerProvider.notifier)
          .updateQty("pending", result.serviceMetadata?.totalPending);
      ref.read(commonQtyControllerProvider.notifier)
          .updateQty("confirmed", result.serviceMetadata?.totalConfirmed);
      ref.read(commonQtyControllerProvider.notifier)
          .updateQty("in_progress", result.serviceMetadata?.totalInProgress);
      ref.read(commonQtyControllerProvider.notifier)
          .updateQty("completed", result.serviceMetadata?.totalCompleted);
      for (var item in result.items) {
        ref.read(serviceItemProvider(item.bookId).notifier).state = item;
      }
      return result.items;
    } catch (e) {
      return [];
    }
  }

  Future<bool> updateStatusService(int id, String status) async {
    try {
      final result = await ref
          .read(serviceRepositoryProvider)
          .updateStatusService(id, status)
          .showErrorBy(this)
          .map(onValue: (value) => value ?? false)
          .mapToValueOr(defaultValue: false).asFuture();
      return result;
    } catch (e) {
      return false;
    }
  }

  void updateTypeSelected(UserExpectEnum? typeSelected){
    state = state.copyWith(typeSelected: typeSelected);
  }

  void updateStatusSelected(StatusServiceEnum? statusSelected){
    state = state.copyWith(statusSelected: statusSelected);
  }

}

final serviceControllerProvider = NotifierProvider.autoDispose.family
    <ServiceController, ServiceControllerState, StatusServiceEnum?>(() => ServiceController());