import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(text),
    ));
}

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}

Future<List<AssetEntity>> fetchAssets(int size) async {
  final FilterOptionGroup filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );

  final PermissionState permissionState =
      await PhotoManager.requestPermissionExtend();
  if (!permissionState.hasAccess) {
    print('Permission is not accessible.');
    return [];
  }

  final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
    type:RequestType.image,
    onlyAll: true,
    filterOption: filterOptionGroup,
  );

  if (paths.isEmpty) {
    print('No paths found.');
    return [];
  }

  final AssetPathEntity path = paths.first;
  final List<AssetEntity> entities = await path.getAssetListPaged(
    page: 0,
    size: size,
  );

  return entities;
}
