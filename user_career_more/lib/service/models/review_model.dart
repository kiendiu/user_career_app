import 'package:user_career_core/user_career_core.dart';

class ReviewModel implements Decodable{
  int? rating;
  String? comments;

  ReviewModel({
    this.rating,
    this.comments,
  });


  ReviewModel copyWith({
    int? rating,
    String? comments,
  }) {
    return ReviewModel(
      rating: rating ?? this.rating,
      comments: comments ?? this.comments,
    );
  }
  @override
  void decode(json) {
    rating = json['rating'];
    comments = json['comments'];
  }
}