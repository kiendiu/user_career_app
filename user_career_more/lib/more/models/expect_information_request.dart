import 'package:user_career_core/user_career_core.dart';

class ExpectInformationRequest implements Encodable{
  int? experienceYears;
  String? skillDescription;
  List<int>? languages;

  ExpectInformationRequest({
    this.experienceYears,
    this.skillDescription,
    this.languages,
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
  }) {
    return ExpectInformationRequest(
      experienceYears: experienceYears ?? this.experienceYears,
      skillDescription: skillDescription ?? this.skillDescription,
      languages: languages ?? this.languages,
    );
  }
}