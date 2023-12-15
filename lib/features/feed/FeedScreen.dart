
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/app_bar.dart';
import '../HomeFeed/post.dart';
import '../add outfit/controllers/outfit_controller.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  // int _page = 0;
  @override
  Widget build(BuildContext context) {
    final outfits = ref.watch(getOutfitsProvider);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: outfits.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text(error.toString()),
            data: (outfit) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: outfit.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        outfit[index].imageLinks.first,
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.cover,
                        height: ((MediaQuery.of(context).size.width - 70) / 2) *
                            5 /
                            4,
                      ),
                      HeadingText(
                        heading: outfit[index].title,
                      )
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}
