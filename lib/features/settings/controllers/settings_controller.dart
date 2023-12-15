
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/settings_repository.dart';

final settingProvider = Provider<SettingController>((ref) {
  return SettingController(
    settingRepository: ref.watch(settingRepositoryProvider),
  );
});

class SettingController extends StateNotifier<bool> {
  final SettingRepository _settingRepository;
  SettingController({
    required SettingRepository settingRepository,
  })  : _settingRepository = settingRepository,
        super(false);

  void setUserOption(String option, bool value) {
    _settingRepository.setUserChoices(option, value);
  }

  // void getUserOptions()
}
