import 'dart:developer';


import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

import '../../HomeFeed/post.dart';
import 'format_markdown.dart';
import 'markdown.dart';

class DescriptionComponent extends ConsumerStatefulWidget {
  const DescriptionComponent({super.key, required this.controller});
  final TextEditingController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DescriptionComponentState();
}

class _DescriptionComponentState extends ConsumerState<DescriptionComponent> {
  String description = "";
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadingText(heading: "Description"),
          MarkdownTextInput(
            (String value) => setState(() => description = value),
            "description",
            maxLines: 10,
            actions: const [
              MarkdownType.bold,
              MarkdownType.italic,
              MarkdownType.list
            ],
            controller: widget.controller,
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                show = true;
              });
              log(widget.controller.text);
            },
            child: const Text("Show"),
          ),
          if (show) MarkdownViewer(widget.controller.text),
        ],
      ),
    );
  }
}
