import 'package:user_career_core/user_career_core.dart';

class LanguageModel implements Decodable {
  int? id;
  String? nameLanguage;

  LanguageModel({this.nameLanguage, this.id});

  @override
  void decode(json) {
    id = json?['language_id'];
    nameLanguage = json?['name_language'];
  }
}