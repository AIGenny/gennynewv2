import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../core/constants/constants.dart';
import '../../../models/outfit_model.dart';
import '../../../router.dart';
import '../../components/components.dart';
import '../components/format_markdown.dart';
import '../components/markdown.dart';
import '../controllers/outfit_controller.dart';

enum TextFormatting { none, bold, italics, list }

class AddOutfitScreen extends ConsumerStatefulWidget {
  const AddOutfitScreen({super.key});
  // final AssetEntity assetEntity;

  @override
  AddOutfitScreenState createState() => AddOutfitScreenState();
}

class AddOutfitScreenState extends ConsumerState<AddOutfitScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode descNode = FocusNode();
  String description = "";
  final HtmlEditorController controller = HtmlEditorController();
  String descriptionText = "";
  List<TextFormatting> formatting = [];
  bool isDescBold = false, isDescItalic = false, isDescListed = false;
  bool isLoading = false;
  int? color;
  bool isOutfitTypeListOpen = false;
  String? size, outfitType;
  final List<TextEditingController> urlController = [TextEditingController()];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final outfitController = ref.watch(outFitControllerProvider);

    if (outfitController.file == null &&
        outfitController.Images.isEmpty &&
        outfitController.imageFromUrl == null) {
      return const Scaffold(
        body: Center(
          child: Text('Please choose atleast one image'),
        ),
      );
    }

    int horizontalTileCount = outfitController.Images.length;
    if (outfitController.file != null) {
      horizontalTileCount++;
    } else if (outfitController.imageFromUrl != null) {
      horizontalTileCount++;
    }

    // q.QuillController _controller = q.QuillController.basic();

    return WillPopScope(
      onWillPop: () {
        log("Backing");
        outfitController.removeOutfitfromController();
        return true as Future<bool>;
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: const CustomAppBar(),
          body: !isLoading
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: ListView(
                    children: [
                      if (outfitController.imageFromUrl != null)
                        Image.network(
                          outfitController.imageFromUrl!,
                          errorBuilder: (ctx, error, stacktrace) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.width - 32,
                              child: const Center(
                                child: Text("Invalid Url"),
                              ),
                            );
                          },
                        )
                      else if (outfitController.file != null)
                        SizedBox(
                          height: MediaQuery.of(context).size.width - 32,
                          width: MediaQuery.of(context).size.width - 32,
                          child: Image.file(
                            File(outfitController.file!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        SizedBox(
                          height: MediaQuery.of(context).size.width - 32,
                          width: MediaQuery.of(context).size.width - 32,
                          child: Image.file(
                            File(outfitController.Images[0].path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: horizontalTileCount,
                          itemBuilder: (_, index) {
                            if (index == 0) {
                              return Container(
                                height: 93,
                                width: 93,
                                margin: const EdgeInsets.fromLTRB(0, 10, 5, 5),
                                decoration:
                                    const BoxDecoration(color: Colors.black),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        navigateTo(
                                          context,
                                          Routes.cameraFolderScreen,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      'Add More',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              );
                            }
                            return Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 5, 5),
                                  child: SizedBox(
                                    height: 93,
                                    width: 93,
                                    child: Image.file(
                                      outfitController.Images[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: const Icon(Icons.delete, size: 15),
                                    onPressed: () {
                                      outfitController.Images.removeAt(index);
                                      setState(() {});
                                    },
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      CustomTextFormField(
                        controller: titleController,

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

                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      const HeadingText(heading: "Size"),
                      SizedBox(
                        height: 45,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: Constants.sizes
                              .map((e) => SizeButtons(
                              size: e,
                              bgColor:
                              e == size ? Colors.blue : Colors.white,
                              onPressed: () {
                                setState(() {
                                  size = e;
                                });
                              }))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      const HeadingText(heading: "Color"),
                      SizedBox(
                        height: 45,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: Constants.colors
                              .map(
                                (e) => ColorButton(
                              color: e,
                              bgColor: e.value == color
                                  ? Colors.black
                                  : Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  color = e.value;
                                });
                              },
                            ),
                          )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
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
                            HeadingText2(
                                heading: outfitType ?? "Choose Outfit Type"),
                            const Expanded(child: SizedBox()),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isOutfitTypeListOpen = !isOutfitTypeListOpen;
                                });
                              },
                              icon: Icon(
                                isOutfitTypeListOpen
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (isOutfitTypeListOpen)
                        Column(
                          children: Constants.outfitType.map((e) {
                            return InkWell(
                              onTap: () => setState(() {
                                outfitType = e;
                                isOutfitTypeListOpen = !isOutfitTypeListOpen;
                              }),
                              child: Container(
                                width: (MediaQuery.of(context).size.width - 32),
                                height: 48,
                                padding:
                                const EdgeInsets.fromLTRB(12, 13, 12, 13),
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.50,
                                      color: Color.fromARGB(157, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                child: Center(
                                    child: Row(
                                      children: [
                                        HeadingText2(heading: e),
                                      ],
                                    )),
                              ),
                            );
                          }).toList(),
                        ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      const HeadingText(heading: "Add Tags"),
                      CustomTextFormField(
                        hintText: "Add text to easily sort and filter",
                        controller: tagsController,
                      ),
                      const SizedBox(height: 8),

                      const HeadingText(heading: "Purchase URL"),
                      Column(
                        children: urlController.mapWithIndex<Widget>((purchaseUrl, index) {
                          return SizedBox(
                            child: CustomTextFormField(
                              controller: urlController[index],
                              hintText: "Add Myntra or Amazon Affiliate Link",
                              suffixIconButton: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.paste),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(color: Colors.black)),
                          onPressed: () {
                            if (urlController.last.text.isNotEmpty) {
                              setState(() {
                                urlController.add(TextEditingController());
                              });
                            }
                          },
                          child: Text(
                            "Add more links",
                            style: TextStyle(
                              color: urlController.last.text.isNotEmpty
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),

                      // UrlFormField(urlController: urlController),
                      const SizedBox(height: 8),

                      const HeadingText(heading: "Description"),

                      HtmlEditor(controller: controller,
                        otherOptions: OtherOptions(height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        htmlToolbarOptions: const HtmlToolbarOptions(
                            defaultToolbarButtons: [
                              FontButtons(),
                              ParagraphButtons(lineHeight: false, caseConverter: false)
                            ]
                        ),
                      )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          bottomNavigationBar: SizedBox(
            height: 75,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 5, 0),
                    color: titleController.text.isEmpty
                        ? Colors.grey
                        : Colors.black,
                    child: CustomTextButton(
                      title: 'Save to wardrobe',
                      onPressed: titleController.text.isEmpty
                          ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Validation failed. Please correct the form.'),
                            duration: Duration(seconds: 2), // You can adjust the duration as needed.
                          ),
                        );
                      }
                          : () {
                        if(_formKey.currentState!.validate()) {
                           saveToWardrobe(outfitController);
                        }else{

                        }
                      }
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  color:
                      titleController.text.isEmpty ? Colors.grey : Colors.black,
                  child: IconButton(
                    onPressed: titleController.text.isEmpty
                        ? () {}
                        : () => preview(outfitController),
                    icon: const Icon(
                      Icons.visibility_outlined,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void preview(OutfitController outfitController) {
    outfitController.outfitTitle = titleController.text;
    outfitController.outfitLink = urlController.last.text;
    outfitController.outfitDescription = descriptionText;
    navigateTo(context, Routes.previewScreen);
  }
  List<String> getTagList(String tags) {
    List<String> tagList = [];
    int li = 0;
    for (int i = 0; i < tags.length; i++) {
      if (tags[i] == ' ') {
        tagList.add(tags.substring(li, i));
        li = i + 1;
      }
    }
    tagList.add(tags.substring(li));

    return tagList;
  }
  void saveToWardrobe(OutfitController outfitController) async {
    setState(() {
      isLoading = true;
    });
    await outfitController
        .addOutfit(
      OutfitModel(
        imageLinks: [],
        color: color,
        size: size,
        tags: getTagList(tagsController.text),
        outfitType: outfitType,
        title: titleController.text.toLowerCase(),
        purchaseUrls:
        urlController.map((controller) => controller.text).toList(),
        description: descriptionText,
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
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final String title;

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}


class ColorButton extends StatelessWidget {
  const ColorButton({
    super.key,
    required this.color,
    required this.bgColor,
    required this.onPressed,
  });

  final Color color, bgColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        width: 45,
        child: TextButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: bgColor),
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: color,
          ),
          onPressed: onPressed,
          child: const Text(""),
        ),
      ),
    );
  }
}
class SizeButtons extends StatelessWidget {
  const SizeButtons({
    super.key,
    required this.size,
    required this.bgColor,
    required this.onPressed,
  });
  final String size;
  final Color bgColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(width: 0.5),
          ),
          backgroundColor: bgColor,
        ),
        onPressed: onPressed,
        child: HeadingText(
          heading: size,

        ),
      ),
    );
  }
}