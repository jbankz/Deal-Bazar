class LanguageModel {
  String? language;
  String? second;
  bool selected;

  LanguageModel({this.language, this.second, required this.selected});
}

List<LanguageModel> languages = [
  LanguageModel(selected: false, language: 'Arabic', second: 'عربي'),
  LanguageModel(selected: false, language: 'English', second: ''),
];
