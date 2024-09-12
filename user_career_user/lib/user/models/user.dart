import 'package:user_career_core/user_career_core.dart';

class User {
  int? id;
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
}

class UserModel extends User implements Decodable {
  @override
  void decode(json) {
    var data = json['data'];
    id = data?['user_id'];
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