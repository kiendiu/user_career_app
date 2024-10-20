import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/booking/models/booking_request.dart';
import 'package:user_career_home/booking/models/booking_response.dart';
import 'package:user_career_home/booking/models/payment_request.dart';
import 'package:user_career_home/booking/repositories/booking_repository.dart';

class BookingController extends AutoDisposeNotifier<BookingRequest>
  with AlertMixin, MetadataUpdater{
  @override
  BookingRequest build() {
    return BookingRequest();
  }

  Future<BookingResponse> createBooking() async {
    try {
      final result = await ref
        .read(bookingRepositoryProvider)
        .createBooking(state)
        .showErrorBy(this)
        .map(onValue: (value) => value ?? BookingResponse())
        .mapToValueOr(defaultValue: BookingResponse()).asFuture();
      return result;
    } catch (e) {
      return BookingResponse();
    }
  }

  Future<bool> createPayment(PaymentRequest request) async {
    try {
      final result = await ref
        .read(bookingRepositoryProvider)
        .createPayment(request)
        .showErrorBy(this)
        .map(onValue: (value) => value ?? false)
        .mapToValueOr(defaultValue: false).asFuture();
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteBooking(int id) async {
    try {
      final result = await ref
        .read(bookingRepositoryProvider)
        .deleteBooking(id)
        .showErrorBy(this)
        .map(onValue: (value) => value ?? false)
        .mapToValueOr(defaultValue: false).asFuture();
      return result;
    } catch (e) {
      return false;
    }
  }

  void updateBookId(int bookId) {
    state = state.copyWith(bookId: bookId);
  }

  void updateServiceId(int serviceId) {
    state = state.copyWith(serviceId: serviceId);
  }

  void updateExpertId(int expertId) {
    state = state.copyWith(expertId: expertId);
  }

  void updateScheduleTime({DateTime? date,  DateTime? time}) {
    final scheduleTime = DateTime(
      date!.year, date.month, date.day, time!.hour, time.minute, time.second
    );
    state = state.copyWith(scheduleTime: scheduleTime);
  }

  void updateDuration(int duration) {
    state = state.copyWith(duration: duration);
  }

  void updateTotalPrice(double totalPrice) {
    state = state.copyWith(totalPrice: totalPrice);
  }

  void updateNoteMessage(String noteMessage) {
    state = state.copyWith(noteMessage: noteMessage);
  }

  void updateContactMethod(String contactMethod) {
    state = state.copyWith(contactMethod: contactMethod);
  }

  void updateLocationName(String locationName) {
    state = state.copyWith(locationName: locationName);
  }

  void updateAddress(String address) {
    state = state.copyWith(address: address);
  }

}

final bookingControllerProvider = NotifierProvider.autoDispose<BookingController, BookingRequest>(() {
  return BookingController();
});