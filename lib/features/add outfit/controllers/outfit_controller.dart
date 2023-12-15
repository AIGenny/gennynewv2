import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../models/outfit_model.dart';
import '../repository/outfit_repository.dart';
import 'package:http/http.dart' as http;
final outFitControllerProvider = Provider<OutfitController>((ref) {
  return OutfitController(outfitReposity: ref.watch(outfitReposityProvider));
});

final getOutfitsProvider = StreamProvider<List<OutfitModel>>((ref) {
  final outfitController = ref.watch(outFitControllerProvider);
  return outfitController.getOutfits();
});

enum PostOutfitStatus {
  editing,
  uploadingImages,
  uploadingOutfit,
  uploaded,
  error,
}

class OutfitController extends StateNotifier<bool> {
  final OutfitReposity _outfitReposity;
  final List<AssetEntity> outfitImages = [];
  final List<File> Images = [];

  String outfitTitle = "";
  String outfitLink = "";
  String outfitDescription = "";
  PostOutfitStatus status = PostOutfitStatus.editing;
  bool isLoading = false;

  XFile? file;
  String? imageFromUrl;

  void removeOutfitfromController() {
    outfitImages.clear();
    outfitTitle = "";
    outfitLink = "";
    outfitDescription = "";
    Images.clear();
  }

  OutfitController({
    required OutfitReposity outfitReposity,
  })  : _outfitReposity = outfitReposity,
        super(false);

  addOutfitToController(AssetEntity outfit) async {
    state = true;
    bool exists = outfitImages.where((element) => element.id == outfit.id).isNotEmpty;
    if (!exists) {
      outfitImages.add(outfit);
    }
    state = false;
  }

  removeOutfit(String id) {
    outfitImages.removeWhere((element) => element.id == id);
  }

  Future<List<String>> _uploadOutFitImages() async {
    List<String> imageUrls = [];
    try {
      if (imageFromUrl != null && imageFromUrl!.isNotEmpty) {
        imageUrls.add(imageFromUrl!);
      }
      if (file != null) {
        final String? imageUrl = await _outfitReposity.uploadImageFromFile(
          File(file!.path),
          DateTime.now().millisecondsSinceEpoch.toString(),
        );
        if (imageUrl != null) imageUrls.add(imageUrl);
      }
      for (var entity in Images) {
        final String? imageUrl = await _outfitReposity.uploadImage(
          entity,
          DateTime.now().millisecondsSinceEpoch.toString(),
        );
        if (imageUrl != null) imageUrls.add(imageUrl);
      }
      return imageUrls;
    } catch (e) {
      status = PostOutfitStatus.error;
      rethrow;
    }
  }


  Future<bool> addOutfit(OutfitModel outfit) async {
    // status = PostOutfitStatus.uploadingOutfit;
    isLoading = true;
    try {
      outfit.imageLinks = await _uploadOutFitImages();
      await _outfitReposity.addOutfit(outfit);
      status = PostOutfitStatus.uploaded;
      isLoading = false;
      return true;
    } catch (e) {
      // status = PostOutfitStatus.error;
      isLoading = false;
      rethrow;
    }
  }

  Stream<List<OutfitModel>> getOutfits() {
    return _outfitReposity.getOutfits();
  }

  Stream<List<OutfitModel>> searchOutfits(String title) {
    return _outfitReposity.searchOutfits(title);
  }
}
