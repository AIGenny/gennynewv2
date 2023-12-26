

import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

import '../../core/providers/firebase_providers.dart';
import '../../router.dart';
import '../components/components.dart';
import 'controllers/myoutfit_controller.dart';

class DetailedOutfitScreen extends ConsumerStatefulWidget {
  DetailedOutfitScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailedOutfitScreen();
}

class _DetailedOutfitScreen extends ConsumerState<DetailedOutfitScreen> {

  String url1="";
  void _getMetadata(String url) async {
    if (!mounted) return; // Check if the widget is still mounted

    try {
      var iconUrl = await FaviconFinder.getBest(url);
      setState(() {
        url1 = iconUrl!.url;
      });
    } catch (e) {
      // Handle any exceptions that might occur during the asynchronous operation
      print("Error fetching metadata: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    final outfit = ref.watch(myOutfitProvider).outfitModel!;
    final uid = ref.watch(authProvider).currentUser!.uid;
    int horizontalImageTileCount = outfit.imageLinks.length - 1;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: ListView(
          children: [
            Stack(
              children: [
                Image.network(
                  outfit.imageLinks[0],
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
            if (horizontalImageTileCount > 0)
              SizedBox(
                height: 100,
                width: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: horizontalImageTileCount,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 5),
                      child: Image.network(
                        outfit.imageLinks[index + 1],
                        height: 93,
                        width: 93,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),
            HeadingText(heading: outfit.title),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(text: "0"),
                  TextSpan(
                      text: " Likes & ",
                      style: TextStyle(fontWeight: FontWeight.w200)),
                  TextSpan(text: "0"),
                  TextSpan(
                      text: " Comments",
                      style: TextStyle(fontWeight: FontWeight.w200)),
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
                  height: 50,
                  width: 50,
                  child: url1.isNotEmpty?Image.network(url1):Center(child: CircularProgressIndicator(),),
                ),
                const Expanded(child: SizedBox())
              ],
            ),
            const SizedBox(height: 20),
            const HeadingText(heading: "Product Description"),
            MarkdownViewer(
              outfit.description,
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        color: Colors.black,
        child: IconButton(
          onPressed: () {
            navigateTo(context, Routes.editOutfitScreen);
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
