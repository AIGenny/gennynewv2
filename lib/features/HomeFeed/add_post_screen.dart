import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/common/app_bar.dart';
import '../../core/utilies.dart';
import '../auth/controller/auth_controller.dart';
import 'firestore_methods.dart';


class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {


  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  XFile? _file;

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  final imagePicker = ImagePicker();
                  _file  = await imagePicker.pickImage(source: ImageSource.camera);
                  if (_file != null) {
                    CroppedFile? croppedImage = await ImageCropper().cropImage(
                      sourcePath: _file!.path,
                      maxWidth: 1080,
                      maxHeight: 1080,
                    );
                    if (croppedImage!=null){
                      setState(() {
                        _file=XFile(croppedImage.path);
                      });
                    }

                  }
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.pop(context);
                  final imagePicker = ImagePicker();
                  _file = await imagePicker.pickImage(source: ImageSource.gallery);
                  if (_file != null) {
                    CroppedFile? croppedImage = await ImageCropper().cropImage(
                      sourcePath: _file!.path,
                      maxWidth: 1080,
                      maxHeight: 1080,
                    );
                    if (croppedImage!=null){
                      setState(() {
                        _file=XFile(croppedImage.path);
                      });

                    }
                  }
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        if (context.mounted) {
          showSnackBar(
            context,
            'Posted!',
          );
        }
        clearImage();
      } else {
        if (context.mounted) {
          showSnackBar(context, res);
        }
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }


  void clearImage() {
    setState(() {
      _file = null;
    });
  }
  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return _file==null?Scaffold(
      appBar: CustomAppBar(),
      body: Container(
          child:Center(
            child: IconButton(
              icon: const Icon(
                Icons.upload,
              ),
              onPressed: () => _selectImage(context),
            ),
          )
      ),
    )
        : Scaffold(
            appBar:CustomAppBar(),

            body: Column(
              children: <Widget>[
                isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0.0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //     "https://www.figma.com/file/zCizN1462iByuK1AlTj29K/FashionX-(Genny)?node-id=226%3A6913&mode=dev"
                    //   ),
                    // ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: _descriptionController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                        ),
                        decoration: const InputDecoration(
                            hintText: "Write a caption...",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45.0,
                      width: 45.0,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                            image: FileImage(File(_file!.path)),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                TextButton(
                  onPressed: () => postImage(
                    user!.uid,
                    user!.name,
                    user!.profilePic,
                  ),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )
              ],
            ),
          );
  }
}
