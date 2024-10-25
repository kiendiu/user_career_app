import 'package:user_career_more/calendar/models/user_expect_enum.dart';
import 'package:user_career_more/service/models/status_service_enum.dart';

class  ServiceControllerState{
  UserExpectEnum? typeSelected;
  StatusServiceEnum? statusSelected;

  ServiceControllerState({this.typeSelected, this.statusSelected});

  ServiceControllerState copyWith({UserExpectEnum? typeSelected, StatusServiceEnum? statusSelected}){
    return ServiceControllerState(
      typeSelected: typeSelected ?? this.typeSelected,
      statusSelected: statusSelected ?? this.statusSelected
    );
  }
}