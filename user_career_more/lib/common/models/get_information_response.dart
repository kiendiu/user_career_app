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
  String? language;
  int? experienceYears;
  String? skillDescription;

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
    language = data?['language'];
    experienceYears = data?['experience_years'];
    skillDescription = data?['skill_description'];
  }
}