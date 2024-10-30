import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/service/models/review_request.dart';
import 'package:user_career_more/service/repositories/service_repository.dart';

class AddReviewController extends AutoDisposeNotifier<ReviewRequest>
  with AlertMixin, MetadataUpdater{
  @override
  ReviewRequest build() {
    return ReviewRequest();
  }

  Future<bool> addReview(int id) async {
    try {
      final result = await ref
          .read(serviceRepositoryProvider)
          .addReview(id, state)
          .showErrorBy(this)
          .map(onValue: (value) => value ?? false)
          .mapToValueOr(defaultValue: false).asFuture();
      return result;
    } catch (e) {
      return false;
    }
  }

  void updateRating(int rating) {
    state = state.copyWith(rating: rating);
  }

  void updateReview(String review) {
    state = state.copyWith(comments: review);
  }
}

final addReviewControllerProvider = NotifierProvider.autoDispose<AddReviewController, ReviewRequest>(() {
  return AddReviewController();
});