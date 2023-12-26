import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gennynewv2/features/HomeFeed/post.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    this.title = 'Genny',
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        Builder(builder: (context) {
          return IconButton(
            onPressed: () { displayEndDrawer(context);
              },
            icon: const Icon(
              Icons.whatshot_outlined,

              size: 28,
            ),
          );
        }),
      ],
    );
  }
}
