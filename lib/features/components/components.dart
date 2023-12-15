
import 'package:flutter/material.dart';

import '../../router.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({
    super.key,
    required this.heading,
  });
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading.capitalize(),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black),
    );
  }
}

class HeadingText2 extends StatelessWidget {
  const HeadingText2({
    super.key,
    required this.heading,
  });
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasSearch;
  final Function()? searchFunction;

  const CustomAppBar({
    Key? key,
    this.title = 'Genny',
    this.hasSearch = false,
    this.searchFunction,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userProvider)!;

    return AppBar(
      title: Text(
        title.capitalize(),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: false,
      actions: [
        if (hasSearch)
          IconButton(
            onPressed: searchFunction,
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 28,
            ),
          ),
        IconButton(
          onPressed: () {
            navigateTo(context, Routes.settingScreen);
          },
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.settings_outlined,
            color: Colors.black,
            size: 28,
          ),
        ),
        IconButton(
          onPressed: () {
            navigateTo(context, Routes.aboutScreen);
          },
          icon: const Icon(
            Icons.whatshot_outlined,
            color: Colors.black,
            size: 28,
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.suffixIconButton,
      this.hintText,
      this.title,
      this.minLines = 1,
      this.validator,
      this.initialValue,
      this.onChanged,
      this.onEditingComplete,
      this.focusNode,
      this.textInputAction,
      this.textDirection,
      this.textCapitalization,
      });
  final IconButton? suffixIconButton;
  final TextEditingController? controller;
  final String? hintText, title, initialValue;
  final int minLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 2),
              child: Text(
                title ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
              ),
            ),
          TextFormField(
            // textCapitalization: textCapitalization, 
            textDirection: textDirection,
            textInputAction: textInputAction,
            focusNode: focusNode,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            initialValue: initialValue,
            minLines: minLines,
            maxLines: minLines > 1 ? (minLines * 2) : 1,
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(
                  width: 0.5,
                  color: Colors.black,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(
                  width: 0.5,
                  color: Colors.black,
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(
                  width: 0.5,
                  color: Colors.black12,
                ),
              ),
              focusedErrorBorder:const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(
                  width: 0.5,
                  color: Colors.black26,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(
                  width: 0.5,
                  color: Colors.red,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              hintText: hintText,
              hintStyle: const TextStyle(fontWeight: FontWeight.w100),
              suffixIcon: suffixIconButton,
            ),
            validator: validator,
          ),

        ],
      ),
    );
  }
}
