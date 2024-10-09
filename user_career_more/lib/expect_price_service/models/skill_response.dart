import 'package:user_career_core/user_career_core.dart';

class SkillResponse implements Decodable{
  int? skillId;
  String? nameSkill;

  SkillResponse({
    this.skillId,
    this.nameSkill,
  });

  SkillResponse copyWith({
    int? skillId,
    String? nameSkill,
  }) {
    return SkillResponse(
      skillId: skillId ?? this.skillId,
      nameSkill: nameSkill ?? this.nameSkill,
    );
  }
  @override
  void decode(json) {
    skillId = json['skill_id'];
    nameSkill = json['name_skill'];
  }
}