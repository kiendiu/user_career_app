import 'package:user_career_core/user_career_core.dart';

import 'language_model.dart';

class ExpectInformationRequest implements Encodable{
  int? experienceYears;
  String? skillDescription;
  List<int>? languages;
  Set<LanguageModel>? languagesLocal;

  ExpectInformationRequest({
    this.experienceYears,
    this.skillDescription,
    this.languages,
    this.languagesLocal,
  });

  @override
  Map<String, dynamic> encode() {
    return {
      'experience_years': experienceYears,
      'skill_description': skillDescription,
      'languages': languages,
    };
  }

  ExpectInformationRequest copyWith({
    int? experienceYears,
    String? skillDescription,
    List<int>? languages,
    Set<LanguageModel>? languagesLocal,
  }) {
    return ExpectInformationRequest(
      experienceYears: experienceYears ?? this.experienceYears,
      skillDescription: skillDescription ?? this.skillDescription,
      languages: languages ?? this.languages,
      languagesLocal: languagesLocal ?? this.languagesLocal,
    );
  }
}