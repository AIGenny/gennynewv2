
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/outfit_model.dart';
import '../../add outfit/repository/outfit_repository.dart';

final myOutfitProvider = Provider<MyOutfit>((ref) {
  return MyOutfit(outfitReposity: ref.watch(outfitReposityProvider));
});

class MyOutfit extends StateNotifier<bool> {
  final OutfitReposity _outfitReposity;
  OutfitModel? _outfitModel;
  OutfitModel? get outfitModel => _outfitModel;
  MyOutfit({required OutfitReposity outfitReposity})
      : _outfitReposity = outfitReposity,
        super(false);

  void setOutfit(OutfitModel outfit) {
    _outfitModel = outfit;
  }

  Future<bool> editOutfit(OutfitModel outfit) async {
    try {
      await _outfitReposity.editOutfit(outfit);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
