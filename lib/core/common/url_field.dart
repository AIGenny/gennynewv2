import 'package:flutter/material.dart';

import '../../features/post/screens/image_preview.dart';

class UrlInputField extends StatelessWidget {
  final TextEditingController controller;

  const UrlInputField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black, // Set the text color to black
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black54,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black38,
          ),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: 'Enter image URL',
        suffixIcon: IconButton(
          icon: const Icon(Icons.paste_rounded),
          onPressed: () {
            final enteredUrl = controller.text;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImagePreviewScreen(imageUrl: enteredUrl),
              ),
            );
          },
        ),
      ),
    );
  }
}
