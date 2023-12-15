
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/outfit_model.dart';
import '../../router.dart';
import '../add outfit/components/format_markdown.dart';
import '../add outfit/components/markdown.dart';
import '../add outfit/screens/add_outfit_screen.dart';
import '../components/components.dart';
import 'controllers/myoutfit_controller.dart';

class EditOutfitScreen extends ConsumerStatefulWidget {
  const EditOutfitScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditOutfitScreenState();
}

class _EditOutfitScreenState extends ConsumerState<EditOutfitScreen> {
  bool isLoading = false;
  String title = "", desc = "", url = "";

  @override
  Widget build(BuildContext context) {
    final myOutfitController = ref.watch(myOutfitProvider);
    final outfit = myOutfitController.outfitModel!;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: ListView(
                children: [
                  Image.network(
                    outfit.imageLinks[0],
                    height: MediaQuery.of(context).size.width - 32,
                    width: MediaQuery.of(context).size.width - 32,
                    fit: BoxFit.cover,
                  ),
                  if (outfit.imageLinks.length > 1)
                    SizedBox(
                      height: 100,
                      width: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: outfit.imageLinks.length - 1,
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
                  CustomTextFormField(
                    onChanged: (val) {
                      setState(() {
                        title = val;
                      });
                    },
                    initialValue: outfit.title,
                    title: 'Title',
                    hintText: 'Name your current outfit',
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please enter title";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomTextFormField(
                    initialValue: outfit.purchaseUrl,
                    onChanged: (val) {
                      setState(() {
                        url = val;
                      });
                    },
                    hintText: "Add Myntra or Amazon Affiliate Link",
                    title: "Purchase URL",
                    suffixIconButton: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.paste),
                    ),
                  ),
                  const HeadingText(heading: "Description"),
                  MarkdownTextInput(
                    (String value) => setState(() => desc = value),
                    desc,
                    maxLines: 10,
                    actions: const [
                      MarkdownType.bold,
                      MarkdownType.italic,
                      MarkdownType.list
                    ],
                    // controller: descriptionController,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
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
                  title: 'Update',
                  onPressed: () async {
                    if (title.isNotEmpty || url.isNotEmpty || desc.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                      await myOutfitController
                          .editOutfit(
                        OutfitModel(
                          id: outfit.id,
                          imageLinks: outfit.imageLinks,
                          title: title.isNotEmpty ? title : outfit.title,
                          purchaseUrl:
                              url.isNotEmpty ? url : outfit.purchaseUrl,
                          description:
                              desc.isNotEmpty ? desc : outfit.description,
                        ),
                      )
                          .then((value) {
                        setState(() {
                          isLoading = false;
                        });
                        if (value) {
                          navigateTo(context, Routes.feedScreen);
                        }
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
