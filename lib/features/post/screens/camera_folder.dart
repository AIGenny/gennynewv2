// ignore_for_file: library_private_types_in_public_api

import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../router.dart';
import '../../add outfit/controllers/outfit_controller.dart';
import '../../components/components.dart';

class CameraFolderScreen extends ConsumerStatefulWidget {
  const CameraFolderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CameraFolderScreen> createState() => _CameraFolderScreenState();
}

class _CameraFolderScreenState extends ConsumerState<CameraFolderScreen> {
  List<AssetEntity>? images;
  AssetPathEntity? selectedFolder;
  List<AssetPathEntity> albums = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCameraFolders();
  }

  Future<void> fetchCameraFolders() async {
    final PermissionState state = await PhotoManager.requestPermissionExtend();
    if (!mounted) {
      return;
    }

    if (!state.isAuth) {
      // Handle case when permission is not granted
      return;
    }

    try {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: false,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(ignoreSize: true),
          ),
        ),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        selectedFolder = albums.isNotEmpty ? albums.first : null;
        isLoading = false;
      });

      if (selectedFolder != null) {
        await fetchImages(selectedFolder!);
      }
    } catch (e) {
      // Print or handle the error accordingly
      print('Error fetching camera folders: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchImages(AssetPathEntity folder) async {
    try {
      final List<AssetEntity> assets = await folder.getAssetListPaged(
        page: 0,
        size: 10,
      );

      setState(() {
        images = assets;
      });
    } catch (e) {
      // Print or handle the error accordingly
      print('Error fetching images: $e');
    }
  }

  void onFolderSelected(AssetPathEntity? folder) async {
    setState(() {
      selectedFolder = folder;
    });

    if (folder != null) {
      await fetchImages(folder);
    }

    setState(() {
      isFolderListOpen = false;
    });
  }


  bool isFolderListOpen = false;

  @override
  Widget build(BuildContext context) {
    final outfitController = ref.watch(outFitControllerProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadingText(heading: "Select Folder"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 32) * .85,
                        height: 48,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              color: Color(0xFF181818),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 12),
                            HeadingText2(heading: selectedFolder?.name ?? ""),
                            const Expanded(child: SizedBox()),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isFolderListOpen = !isFolderListOpen;
                                });
                              },
                              icon: Icon(
                                isFolderListOpen
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          navigateTo(context, Routes.addOutfitScreen);
                        },
                        icon: const Icon(Icons.done),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (isFolderListOpen)
                  SizedBox(
                    height: 200,
                    child: ListView(
                      children: albums.map((e) {
                        return InkWell(
                          onTap: () => onFolderSelected(e),
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 32),
                            height: 48,
                            padding: const EdgeInsets.fromLTRB(12, 13, 12, 13),
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  color: Color.fromARGB(157, 0, 0, 0),
                                ),
                              ),
                            ),
                            child: Center(child: Row(
                              children: [
                                HeadingText2(heading: e.name),
                              ],
                            )),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  HeadingText(heading: selectedFolder?.name ?? ""),
                  const SizedBox(height: 8),
                  Expanded(
                    child: images != null && images!.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6,
                            ),
                            itemCount: images!.length,
                            itemBuilder: (_, index)  {
                              final AssetEntity image = images![index];
                              return ImageTile(
                                  outfitController: outfitController,
                                  image: image);
                            },
                          )
                        : const Center(
                            child: Text('No images available'),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ImageTile extends StatefulWidget {
  const ImageTile({
    super.key,
    required this.outfitController,
    required this.image,
  });

  final OutfitController outfitController;
  final AssetEntity image;

  @override
  State<ImageTile> createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  bool isSelected = false;
  checkSelected() async {
    widget.outfitController.outfitImages
        .firstWhere((element) => element.id == widget.image.id)
        .exists
        .then((_) {
      setState(() {
        isSelected = true;
      });
    });
  }

  @override
  initState() {
    super.initState();
    // checkSelected();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () async{
          if (!isSelected) {
            File? file=await widget.image.file;
            if (file != null) {
              CroppedFile? croppedImage = await ImageCropper().cropImage(
                sourcePath: file.path,
                maxWidth: 1080,
                maxHeight: 1080,
              );
            widget.outfitController.Images.add(File(croppedImage!.path));
           // widget.outfitController.addOutfitToController(widget.image);
            setState(() {
              isSelected = true;
            });
          } }else {
            // widget.outfitController.removeOutfit(widget.image.id);
              File? file=await widget.image.file;
              widget.outfitController.Images.remove(file);
              setState(() {
              isSelected = false;
            });
        }
          },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.white,
              width: 3,
            ),
          ),
          child: Image(
            image: AssetEntityImageProvider(widget.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
