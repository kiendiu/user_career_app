import 'package:user_career_core/user_career_core.dart';

class UpdateInformationRequest implements Encodable {
  String? avatar;
  String? username;
  String? email;
  String? phone;
  String? address;

  UpdateInformationRequest({this.username, this.email, this.avatar, this.phone, this.address});

  @override
  Map<String, dynamic> encode() {
    return {
      "username": username,
      "email": email,
      "phone": phone,
      "address": address,
      "avatar": avatar
    };
  }

  UpdateInformationRequest copyWith({String? username, String? email, String? avatar, String? phone, String? address}) {
    return UpdateInformationRequest(
        username: username ?? this.username,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        address: address ?? this.address
    );
  }

  bool get canUpdate =>
      username != null &&
          username!.trim().isNotEmpty &&
          email != null &&
          email!.trim().isNotEmpty &&
          email!.isValidEmail();

  bool get isusernameValid =>
      username != null &&
          username!.trim().isNotEmpty &&
          username!.isValidEmail();

  bool get isEmailValid => email != null && email!.trim().isNotEmpty;
}
