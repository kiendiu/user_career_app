import 'package:user_career_core/user_career_core.dart';

class LanguageModel implements Encodable, Decodable {
  int? languageId;
  String? nameLanguage;

  LanguageModel({this.nameLanguage, this.languageId});

  @override
  void decode(json) {
    languageId = json?['language_id'];
    nameLanguage = json?['name_language'];
  }

  @override
  Map<String, dynamic> encode() {
    return {
      'name_language': nameLanguage,
    };
  }

  LanguageModel copyWith({
    int? languageId,
    String? nameLanguage,
  }) {
    return LanguageModel(
      languageId: languageId ?? this.languageId,
      nameLanguage: nameLanguage ?? this.nameLanguage,
    );
  }
}