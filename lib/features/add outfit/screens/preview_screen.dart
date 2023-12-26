import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:any_link_preview/any_link_preview.dart';

import '../../../core/common/app_bar.dart';
import '../../../models/outfit_model.dart';
import '../../../router.dart';
import '../../HomeFeed/post.dart';
import '../controllers/outfit_controller.dart';
import 'add_outfit_screen.dart';

class PreviewScreen extends ConsumerStatefulWidget {
  const PreviewScreen({super.key});

  @override
  ConsumerState<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends ConsumerState<PreviewScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final outfitController = ref.watch(outFitControllerProvider);
    void saveToWardrobe() async {
      setState(() {
        isLoading = true;
      });
      await outfitController
          .addOutfit(
        OutfitModel(
          imageLinks: [],
          title: outfitController.outfitTitle.toLowerCase(),
          purchaseUrls: [],
          description: outfitController.outfitDescription,
        ),
      )
          .then((value) {
        setState(() {
          isLoading = false;
        });
        if (value == true) {
          outfitController.removeOutfitfromController();
          navigateTo(context, Routes.myOutfitScreen, replace: true);
        }
      });
      // navigateTo(context, Routes.myOutfitScreen);
    }


    int horizontalTileCount = outfitController.outfitImages.length - 1;
    if (outfitController.file != null) {
      horizontalTileCount++;
    } else if (outfitController.imageFromUrl != null) {
      horizontalTileCount++;
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: ListView(
          children: [
            if (outfitController.imageFromUrl != null)
              Stack(
                children: [
                  Image.network(
                    outfitController.imageFromUrl!,
                    errorBuilder: (ctx, error, stacktrace) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.width - 32,
                        width: MediaQuery.of(context).size.width - 32,
                        child: const Center(
                          child: Text("Invalid Url"),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            else if (outfitController.file != null)
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width - 32,
                    width: MediaQuery.of(context).size.width - 32,
                    child: Image.file(
                      File(outfitController.file!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            else
              Stack(
                children: [
                  AssetEntityImage(
                    outfitController.outfitImages[0],
                    height: MediaQuery.of(context).size.width - 32,
                    width: MediaQuery.of(context).size.width - 32,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            if (horizontalTileCount > 0)
              SizedBox(
                height: 100,
                width: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: horizontalTileCount,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 5),
                      child: AssetEntityImage(
                        outfitController.outfitImages[index + 1],
                        height: 93,
                        width: 93,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),
            HeadingText(heading: outfitController.outfitTitle),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: "0",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " Likes   &   ",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: "0",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " Comments",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            const HeadingText(heading: "Purchase Options"),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: AnyLinkPreview(
                    borderRadius: 0,
                    bodyMaxLines: 1,
                    errorWidget: const Center(
                      child: Text('Unavailable'),
                    ),
                    link: outfitController.outfitLink,
                  ),
                ),
                const Expanded(child: SizedBox())
              ],
            ),
            const SizedBox(height: 20),
            const HeadingText(heading: "Product Description"),
            MarkdownViewer(outfitController.outfitDescription)
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 5, 0),
                color: Colors.black,
                child: CustomTextButton(
                  title: 'Save',
                  onPressed: saveToWardrobe,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              color: Colors.black,
              child: IconButton(
                onPressed: () {
                  navigateBack(context);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
