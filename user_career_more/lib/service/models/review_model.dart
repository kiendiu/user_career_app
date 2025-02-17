import 'package:user_career_core/user_career_core.dart';

class ReviewModel implements Decodable{
  int? rating;
  String? comment;

  ReviewModel({
    this.rating,
    this.comment,
  });


  ReviewModel copyWith({
    int? rating,
    String? comments,
  }) {
    return ReviewModel(
      rating: rating ?? this.rating,
      comment: comments ?? comment,
    );
  }
  @override
  void decode(json) {
    rating = json['rating'];
    comment = json['comment'];
  }
}