import 'dart:ui';

import 'package:easy_widgets/easy_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/app_bar.dart';
import '../../../core/utilies.dart';
import '../../add outfit/controllers/outfit_controller.dart';
import '../components/image_picker_components.dart';

class ImagePick extends ConsumerStatefulWidget {
  const ImagePick({Key? key}) : super(key: key);

  @override
  ConsumerState<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends ConsumerState<ImagePick> {
  List<AssetEntity>? _entities;
  final linkController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  @override
  void dispose() {
    super.dispose();
    linkController.dispose();
  }

  // Future<void> onSubmit() async {}

  Future<void> loadAssets() async {
    List<AssetEntity> entities = await fetchAssets(15);
    // Do something with the fetched assets
    setState(() {
      _entities = entities;
      _isLoading = false;
    });
  }

  Future<void> selectImage() async {
    FilePickerResult? result = await pickImage();
    if (result != null) {
    } else {}
  }

  void navigateToCameraFolderScreen(BuildContext context) {
    Routemaster.of(context).push('/camera-folder');
  }

  @override
  Widget build(BuildContext context) {
    final outfitController = ref.watch(outFitControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false, // this is new
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Container(
          height: context.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: CameraSection(outfitController: outfitController),
              ),
              Expanded(
                flex: 7,
                child: GallerySection(
                  isLoading: _isLoading,
                  entities: _entities,
                  outfitController: outfitController,
                  linkController: linkController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

