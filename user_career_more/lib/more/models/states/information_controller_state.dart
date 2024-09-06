import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/requests/information_request.dart';
import 'package:user_career_more/more/models/upload_media_response.dart';

class InformationControllerState {
  InformationRequest informationRequest;
  UploadMediaResponse? uploadMediaResponse;
  AppFile? newAvatar;
  bool noDeleteAvatar;

  InformationControllerState(
    {
      required this.informationRequest,
      this.uploadMediaResponse,
      this.newAvatar,
      this.noDeleteAvatar = false,
    }
  );

  InformationControllerState copyWith({
    InformationRequest? informationRequest,
    UploadMediaResponse? uploadMediaResponse,
    AppFile? newAvatar,
    bool? noDeleteAvatar,
  }) {
    return InformationControllerState(
      informationRequest: informationRequest ?? this.informationRequest,
      uploadMediaResponse: uploadMediaResponse ?? this.uploadMediaResponse,
      newAvatar: newAvatar ?? this.newAvatar,
      noDeleteAvatar: noDeleteAvatar ?? this.noDeleteAvatar,
    );
  }
}