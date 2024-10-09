import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/base_selectable_item_view.dart';
import 'package:user_career_more/expect_price_service/models/add_service_user_request.dart';
import 'package:user_career_more/expect_price_service/models/service_user_request.dart';
import 'package:user_career_more/expect_price_service/models/service_user_response.dart';
import 'package:user_career_more/expect_price_service/models/skill_response.dart';
import 'package:user_career_more/expect_price_service/repositories/price_service_repository.dart';

class ServiceUserController extends AutoDisposeAsyncNotifier<ServiceUserResponse> with AlertMixin{
  @override
  FutureOr<ServiceUserResponse> build() {
    return getServiceGeneral();
  }

  Future<ServiceUserResponse> getServiceGeneral() async {
    final result = await ref
        .read(priceServiceRepositoryProvider)
        .getServiceGeneral()
        .showErrorBy(this)
        .mapToValueOr(defaultValue: ServiceUserResponse())
        .asFuture();
    return result;
  }
}

final serviceUserControllerProvider =
AsyncNotifierProvider.autoDispose<ServiceUserController, ServiceUserResponse>(() {
  return ServiceUserController();
});

class PriceServiceController extends AutoDisposeNotifier<ServiceUserRequest> with AlertMixin, MetadataUpdater{
  @override
  ServiceUserRequest build() {
    return ref.watch(serviceUserControllerProvider).maybeWhen(
      data: (data) {
        return ServiceUserRequest(
          serviceId: data.serviceId,
          skillId: data.skillId ,
          timeOnline: data.timeOnline ,
          priceOnline: data.priceOnline,
          timeOffline: data.timeOffline,
          priceOffline: data.priceOffline,
          frames: data.frames?.map((frame) => ServiceFrameRequest(
            serviceFrameId: frame.serviceFrameId,
            weekDay: frame.weekDay,
            startTime: frame.startTime,
            endTime: frame.endTime,
          )).toList(),
          skill: [BaseSelectableItemModel(
              data: SkillResponse(
                skillId: data.skillId,
                nameSkill: data.nameSkill,
              ),
              id: data.skillId,
              name: data.nameSkill,)
          ],
        );
      },
      orElse: () => ServiceUserRequest(),
    );
  }

  Future<bool> addServiceGeneral() async {
    final result = await ref
        .read(priceServiceRepositoryProvider)
        .addServiceGeneral(AddServiceUserRequest(
          timeOnline: state.timeOnline,
          priceOnline: state.priceOnline,
          timeOffline: state.timeOffline,
          priceOffline: state.priceOffline,
          frames: state.frames?.map((frame) => AddServiceFrameRequest(
            weekDay: frame.weekDay,
            startTime: frame.startTime,
            endTime: frame.endTime,
          )).toList(),
    ))
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  Future<bool> updateServiceGeneral() async {
    final result = await ref
        .read(priceServiceRepositoryProvider)
        .updateServiceGeneral(state)
        .showErrorBy(this)
        .mapToValueOr(defaultValue: true)
        .asFuture();
    return result;
  }

  Future<List<BaseSelectableItemModel<SkillResponse>>> getListSkill() async {
    try {
      final result = await ref
          .read(priceServiceRepositoryProvider)
          .getListSkill(BaseParams())
          .updateMetadataBy(this)
          .showErrorBy(this)
          .getItems();
      return result.map((element) {
        return BaseSelectableItemModel<SkillResponse>(
          data: element,
          id: element.skillId,
          name: element.nameSkill,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  void setServiceId(int serviceId) {
    state = state.copyWith(serviceId: serviceId);
  }

  void setSkillId(int skillId) {
    state = state.copyWith(skillId: skillId);
  }

  void setTimeOnline(int timeOnline) {
    state = state.copyWith(timeOnline: timeOnline);
  }

  void setPriceOnline(int priceOnline) {
    state = state.copyWith(priceOnline: priceOnline);
  }

  void setTimeOffline(int timeOffline) {
    state = state.copyWith(timeOffline: timeOffline);
  }

  void setPriceOffline(int priceOffline) {
    state = state.copyWith(priceOffline: priceOffline);
  }

  void setFrames(List<ServiceFrameRequest> frames) {
    state = state.copyWith(frames: frames);
  }

  void setWeekDay(ServiceFrameRequest frameToUpdate, String weekDay) {
    final frames = state.frames?.map((frame) {
      if (identical(frame, frameToUpdate)) {
        return frame.copyWith(weekDay: weekDay);
      }
      return frame;
    }).toList();
    state = state.copyWith(frames: frames);
  }

  void setStartTime(ServiceFrameRequest frameToUpdate, String startTime) {
    final frames = state.frames?.map((frame) {
      if (identical(frame, frameToUpdate)) {
        return frame.copyWith(startTime: startTime);
      }
      return frame;
    }).toList();

    state = state.copyWith(frames: frames);
  }

  void setEndTime(ServiceFrameRequest frameToUpdate, String endTime) {
    final frames = state.frames?.map((frame) {
      if (identical(frame, frameToUpdate)) {
        return frame.copyWith(endTime: endTime);
      }
      return frame;
    }).toList();
    state = state.copyWith(frames: frames);
  }

  void removeItemFrame(ServiceFrameRequest frame) {
    final updatedFrames = List<ServiceFrameRequest>.from(state.frames ?? []);
    updatedFrames.remove(frame);
    state = state.copyWith(frames: updatedFrames);
  }

  void addItemFrame() {
    final updatedFrames = List<ServiceFrameRequest>.from(state.frames ?? []);
    updatedFrames.add(ServiceFrameRequest());
    state = state.copyWith(frames: updatedFrames);
  }
}

final priceServiceControllerProvider =
NotifierProvider.autoDispose<PriceServiceController, ServiceUserRequest>(() {
  return PriceServiceController();
});