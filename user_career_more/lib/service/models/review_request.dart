import 'package:user_career_core/user_career_core.dart';

class ReviewRequest implements Encodable{
  int? rating;
  String? comments;

  ReviewRequest({
    this.rating,
    this.comments,
  });

  ReviewRequest copyWith({
    int? rating,
    String? comments,
  }) {
    return ReviewRequest(
      rating: rating ?? this.rating,
      comments: comments ?? this.comments,
    );
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'rating': rating,
      'comments': comments,
    };
  }

  bool get isEmptyComments => comments != null && comments!.isNotEmpty;

}