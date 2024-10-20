import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_home/booking/models/booking_request.dart';
import 'package:user_career_home/booking/models/booking_response.dart';
import 'package:user_career_home/booking/models/payment_request.dart';
import 'package:user_career_home/core/repository.dart';

abstract interface class IBookingRepository {
  ResultFuture<BookingResponse> createBooking(BookingRequest request);

  ResultFuture<bool> createPayment(PaymentRequest request);

  ResultFuture<bool> deleteBooking(int id);

}

class BookingRepository extends HomeBaseRepository implements IBookingRepository {
  @override
  ResultFuture<BookingResponse> createBooking(BookingRequest request) {
    return make.request(
      path: "/requests/booking",
      body: request.encode(),
      decoder: BookingResponse(),
    ).post();
  }

  @override
  ResultFuture<bool> createPayment(PaymentRequest request) {
    return make.request(
      path: "/requests/payment",
      body: request.encode(),
      decoder: const EmptyResponse(),
    ).post().map(
      onValue: (value) {
        return true;
      },
    );
  }

  @override
  ResultFuture<bool> deleteBooking(int id) {
    return make.request(
      path: "/requests/booking/$id",
      decoder: const EmptyResponse(),
    ).delete().map(
      onValue: (value) {
        return true;
      },
    );
  }


}

final bookingRepositoryProvider = Provider.autoDispose<IBookingRepository>((ref) {
  return BookingRepository();
});