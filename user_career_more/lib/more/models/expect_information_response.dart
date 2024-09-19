import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/language_model.dart';

class ExpectInformationResponse implements Decodable {
  int? experienceYears;
  String? skillDescription;
  List<LanguageModel>? languages;

  @override
  void decode(json) {
    if (json == null) return;
    experienceYears = json['data']['experience_years'];
    skillDescription = json['data']['skill_description'];
    languages = (json['data']['languages'] as List<dynamic>)
        .map((e) => LanguageModel()..decode(e)).toList();
  }
}