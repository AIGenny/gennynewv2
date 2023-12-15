class UserSettingsOption {
  final String option, value;

  UserSettingsOption({
    required this.option,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'option': option,
      'value': value,
    };
  }

  
}
