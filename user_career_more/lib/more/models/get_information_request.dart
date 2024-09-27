import 'package:user_career_core/user_career_core.dart';

class GetInformationRequest implements Encodable {
  String? avatar;
  String? username;
  String? email;
  String? phone;
  String? address;

  GetInformationRequest({this.username, this.email, this.avatar, this.phone, this.address});

  @override
  Map<String, dynamic> encode() {
    return {
      "username": username,
      "email": email,
      "phone": phone,
      "address": address
    };
  }

  GetInformationRequest copyWith({String? username, String? email, String? avatar, String? phone, String? address}) {
    return GetInformationRequest(
        username: username ?? this.username,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        phone: phone ?? this.phone,
        address: address ?? this.address
    );
  }
}