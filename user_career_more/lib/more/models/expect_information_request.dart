import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/approval_enum.dart';

import 'language_model.dart';

class ExpectInformationRequest implements Encodable{
  int? experienceYears;
  String? skillDescription;
  ApprovalEnum? approval;
  List<BaseSelectableItemModel<LanguageModel>>? listLanguages = [];

  ExpectInformationRequest({
    this.experienceYears,
    this.skillDescription,
    this.approval,
    this.listLanguages,
  });

  @override
  Map<String, dynamic> encode() {
    return {
      'experience_years': experienceYears,
      'skill_description': skillDescription,
      'languages': listLanguages?.map((e) => e.id).toList(),
    };
  }

  ExpectInformationRequest copyWith({
    int? experienceYears,
    String? skillDescription,
    ApprovalEnum? approval,
    List<BaseSelectableItemModel<LanguageModel>>? listLanguages,
  }) {
    return ExpectInformationRequest(
      experienceYears: experienceYears ?? this.experienceYears,
      skillDescription: skillDescription ?? this.skillDescription,
      approval: approval ?? this.approval,
      listLanguages: listLanguages ?? this.listLanguages,
    );
  }
}