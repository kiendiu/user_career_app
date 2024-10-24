import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_request/request/models/booking_request.dart';
import 'package:user_career_request/request/models/booking_response.dart';
import 'package:user_career_request/request/models/info_booking_bid_model.dart';
import 'package:user_career_request/request/repositories/request_repository.dart';

class BookingBidController extends AutoDisposeFamilyNotifier<BookingRequest, InfoBookingBidModel>
with AlertMixin, MetadataUpdater{
  @override
  BookingRequest build(InfoBookingBidModel arg) {
    return BookingRequest(
      expertId: arg.expertId,
      requestId: arg.requestId,
      contactMethod: arg.contactMethod,
      locationName: arg.locationName,
      address: arg.address,
      totalPrice: arg.price,
      noteMessage: arg.description,
    );
  }

  Future<BookingResponse> createBooking() async {
    try {
      final result = await ref
          .read(requestRepositoryProvider)
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
          .read(requestRepositoryProvider)
          .createPayment(request)
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

  void updateScheduleTime({DateTime? date,  DateTime? time}) {
    final scheduleTime = DateTime(
        date!.year, date.month, date.day, time!.hour, time.minute, time.second
    );
    state = state.copyWith(scheduleTime: scheduleTime);
  }

  void updateDuration(int duration) {
    state = state.copyWith(duration: duration);
  }

}

final bookingBidControllerProvider = NotifierProvider.autoDispose.family<BookingBidController, BookingRequest, InfoBookingBidModel>(() {
  return BookingBidController();
});