

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/constants.dart';
import '../../router.dart';
import '../add outfit/controllers/outfit_controller.dart';
import '../components/components.dart';
import '../notifications/screens/notification_screen.dart';
import 'controllers/myoutfit_controller.dart';

class MyOutfitScreen extends ConsumerStatefulWidget {
  const MyOutfitScreen({super.key});

  @override
  ConsumerState<MyOutfitScreen> createState() => _MyOutfitScreenState();
}

class _MyOutfitScreenState extends ConsumerState<MyOutfitScreen> {
  bool isSearch = false, showSearchField = false;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final outfitController = ref.watch(outFitControllerProvider);
    final outfits = ref.watch(getOutfitsProvider);
    final myOutfit = ref.watch(myOutfitProvider);

    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        if (isSearch) {
          setState(() {
            isSearch = false;
          });
          return false as Future<bool>;
        } else {
          return true as Future<bool>;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          hasSearch: true,
          searchFunction: () {
            setState(() {
              showSearchField = true;
            });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showSearchField)
                CustomTextFormField(
                  controller: searchController,
                  suffixIconButton: IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = true;
                      });
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              if (showSearchField) const SizedBox(height: 8),
              HeadingText(heading: !isSearch ? "My Outfits" : "Serach Results"),
              if (isSearch)
                Expanded(
                  child: StreamBuilder(
                    stream: outfitController
                        .searchOutfits(searchController.text.toLowerCase()),
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4 / 5,
                            crossAxisSpacing: 5,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                myOutfit.setOutfit(snapshot.data![index]);
                                navigateTo(
                                  context,
                                  Routes.detailedOutfitScreen,
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: ((width - 70) / 2) * 5 / 4,
                                    child: Image.network(
                                      snapshot.data![index].imageLinks.first,
                                      repeat: ImageRepeat.noRepeat,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  HeadingText(
                                    heading: snapshot.data![index].title,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }

                      return const NoResultsWidget(
                        imagePath: AssetImages.noSearchResults,
                        text: "No results found matching your search",
                      );
                    },
                  ),
                ),
              if (!isSearch)
                Expanded(
                  child: outfits.when(
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) => Text(error.toString()),
                    data: (outfit) {
                      if (outfit.isEmpty) {
                        return const NoResultsWidget(
                          imagePath: AssetImages.noOutfits,
                          text:
                              "Go Back And add your favorite outfits to curate a collection",
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 4 / 5,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: outfit.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              myOutfit.setOutfit(outfit[index]);
                              navigateTo(context, Routes.detailedOutfitScreen);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  outfit[index].imageLinks.first,
                                  repeat: ImageRepeat.noRepeat,
                                  fit: BoxFit.cover,
                                  height: ((MediaQuery.of(context).size.width -
                                              100) /
                                          2) *
                                      5 /
                                      4,
                                ),
                                HeadingText(
                                  heading: outfit[index].title,
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
