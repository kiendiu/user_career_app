import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_more/more/models/language_model.dart';

import 'approval_enum.dart';

class ExpectInformationResponse implements Decodable {
  int? experienceYears;
  String? skillDescription;
  ApprovalEnum? approval;
  List<BaseSelectableItemModel<LanguageModel>>? languages = [];
  //List<LanguageModel>? languages;

  @override
  void decode(json) {
    if (json == null) return;
    experienceYears = json['data']['experience_years'];
    skillDescription = json['data']['skill_description'];
    approval = ApprovalEnum.values.firstWhere((element) => element.rawValue == json['data']['approval']);
    languages = json['data']['languages']?.map<BaseSelectableItemModel<LanguageModel>>((e) {
    final language = LanguageModel();
      language.decode(e);
      return BaseSelectableItemModel<LanguageModel>(
        data: language,
        id: language.id,
        name: language.nameLanguage,
      );
    }).toList();
  }
}