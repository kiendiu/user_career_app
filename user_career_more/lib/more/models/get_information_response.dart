import 'package:user_career_core/user_career_core.dart';

class GetInformationResponse implements Decodable{
  int? id;
  String? fullName;
  String? avatar;
  String? phone;
  String? socialMediaUrl;
  String? address;
  double? balanceWallet;
  String? username;
  String? email;
  int? experienceYears;
  String? skillDescription;

  GetInformationResponse({
    this.id,
    this.fullName,
    this.avatar,
    this.phone,
    this.socialMediaUrl,
    this.address,
    this.balanceWallet,
    this.username,
    this.email,
    this.experienceYears,
    this.skillDescription});

  @override
  void decode(json) {
    var data = json['data'];
    id = data?['user_id'];
    fullName = data?['full_name'];
    avatar = data?['avatar'];
    phone = data?['phone'];
    socialMediaUrl = data?['social_media_url'];
    address = data?['address'];
    balanceWallet = data?['balance_wallet']?.toDouble();
    username = data?['username'];
    email = data?['email'];
    experienceYears = data?['experience_years'];
    skillDescription = data?['skill_description'];
  }

  GetInformationResponse copyWith({
    int? id,
    String? fullName,
    String? avatar,
    String? phone,
    String? socialMediaUrl,
    String? address,
    double? balanceWallet,
    String? username,
    String? email,
    int? experienceYears,
    String? skillDescription,
  }) {
    return GetInformationResponse(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      socialMediaUrl: socialMediaUrl ?? this.socialMediaUrl,
      address: address ?? this.address,
      balanceWallet: balanceWallet ?? this.balanceWallet,
      username: username ?? this.username,
      email: email ?? this.email,
      experienceYears: experienceYears ?? this.experienceYears,
      skillDescription: skillDescription ?? this.skillDescription,
    );
  }
}