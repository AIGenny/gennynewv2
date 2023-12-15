import 'dart:io';
import 'dart:ui';

import 'package:easy_widgets/easy_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../core/constants/constants.dart';
import '../../../router.dart';
import '../../add outfit/controllers/outfit_controller.dart';
import '../../components/components.dart';

class CameraSection extends StatelessWidget {
  const CameraSection({
    super.key,
    required this.outfitController,
  });

  final OutfitController outfitController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      width: double.infinity,

      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              Constants.backdrop,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () async {
                final imagePicker = ImagePicker();
                final XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  CroppedFile? croppedImage = await ImageCropper().cropImage(
                    sourcePath: image.path,
                    maxWidth: 1080,
                    maxHeight: 1080,
                    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                  );
                  if (croppedImage!=null)
                    outfitController.file = XFile(croppedImage.path);
                  navigateTo(context, Routes.addOutfitScreen);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GallerySection extends StatelessWidget {
  const GallerySection({
    super.key,
    required bool isLoading,
    required List<AssetEntity>? entities,
    required this.outfitController,
    required this.linkController,
  })  : _isLoading = isLoading,
        _entities = entities;

  final bool _isLoading;
  final List<AssetEntity>? _entities;
  final OutfitController outfitController;
  final TextEditingController linkController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: HeadingText(heading: 'Add from Gallery'),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_entities != null && _entities!.isNotEmpty)
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 7.0,
                mainAxisSpacing: 7.0,
              ),
              itemCount: _entities!.length + 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                if (index == _entities!.length) {
                  return ViewAllTile(outfitController:outfitController);
                } else {
                  return GalleryImageTile(
                    outfitController: outfitController,
                    assetEntity: _entities![index],
                  );
                }
              },
            )
          else
            const Center(
              child: Text('No images found in Gallery.'),
            ),
          CustomTextFormField(
            title: 'Add from URL',
            onEditingComplete: () {
              outfitController.imageFromUrl = linkController.text;
              navigateTo(context, Routes.addOutfitScreen);
            },
            hintText: "Enter URL here",
            controller: linkController,
            suffixIconButton: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.paste,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GalleryImageTile extends StatelessWidget {
  const GalleryImageTile({
    super.key,
    required this.outfitController,
    required this.assetEntity,
  });

  final OutfitController outfitController;
  final AssetEntity assetEntity;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () async {
          File? file=await assetEntity.file;
          if (file != null) {
            CroppedFile? croppedImage = await ImageCropper().cropImage(
              sourcePath: file.path,
              maxWidth: 1080,
              maxHeight: 1080,
              aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
            );
            if (croppedImage!=null)
              outfitController.file = XFile(croppedImage.path);
            outfitController.file.isNotNull?navigateTo(context, Routes.addOutfitScreen):null;
          }
          // outfitController.addOutfitToController(assetEntity);
          // navigateTo(context, Routes.addOutfitScreen);
        },
        child: Image(
          image: AssetEntityImageProvider(assetEntity),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ViewAllTile extends StatelessWidget {
  ViewAllTile({
    super.key,
    required this.outfitController
  });
  final OutfitController outfitController;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.black87,
        child: GridTile(
          child: InkWell(
            onTap: () async{
              final imagePicker = ImagePicker();
              final List<XFile>? list= await imagePicker.pickMultiImage(requestFullMetadata: true,);

              for (XFile xFile in list!) {
                File file = File(xFile.path);
                if (file != null) {
                  CroppedFile? croppedImage = await ImageCropper().cropImage(
                    sourcePath: file.path,
                    maxWidth: 175,
                    maxHeight: 150,
                    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                  );
                  outfitController.Images.add(File(croppedImage!.path));}
              }
              outfitController.Images.isNotEmpty?navigateTo(context, Routes.addOutfitScreen):null;
            },

            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white70,
                ),
                SizedBox(height: 8.0),
                Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
