import 'package:user_career_core/user_career_core.dart';

class BookingResponse implements Decodable{
  int? success;
  String? message;
  int? bookId;

  BookingResponse({
    this.success,
    this.message,
    this.bookId
  });

  BookingResponse copyWith({
    int? success,
    String? message,
    int? bookId
  }) {
    return BookingResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      bookId: bookId ?? this.bookId
    );
  }
  @override
  void decode(json) {
    success = json['success'];
    message = json['message'];
    bookId = json['book_id'];
  }

}