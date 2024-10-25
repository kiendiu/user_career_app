import 'package:user_career_core/user_career_core.dart';

class TotalResponse implements Decodable{
  int? totalPending;
  int? totalConfirmed;
  int? totalInProgress;
  int? totalCompleted;

  @override
  void decode(json){
    totalPending = json['metadata']?['total_pending'];
    totalConfirmed = json['metadata']?['total_confirmed'];
    totalInProgress = json['metadata']?['total_in_progress'];
    totalCompleted = json['metadata']?['total_completed'];
  }

  bool get checkServiceStatusPending => (totalPending ?? 0) > 0;

  bool get checkServiceStatusConfirmed => (totalConfirmed ?? 0) > 0;

  bool get checkServiceStatusInProgress => (totalInProgress ?? 0) > 0;

  bool get checkServiceStatusCompleted => (totalCompleted ?? 0) > 0;
}