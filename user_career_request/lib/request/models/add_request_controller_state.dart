import 'package:user_career_request/request/models/request.dart';

class AddRequestControllerState {
  Request request;
  String selectedContactMethod;

  AddRequestControllerState({
    required this.request,
    required this.selectedContactMethod
  });

  AddRequestControllerState copyWith({
    Request? request,
    String? selectedContactMethod,
  }){
    return AddRequestControllerState(
        request: request ?? this.request,
        selectedContactMethod: selectedContactMethod ?? this.selectedContactMethod
    );
  }
}