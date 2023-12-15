// ignore_for_file: library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/app_bar.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  void navigateToImagePickScreen(BuildContext context) {
    Routemaster.of(context).push('/image-pick');
  }

  List<String> imageUrls = [
    'https://tinyjpg.com/images/social/website.jpg',
    'https://imgv3.fotor.com/images/slider-image/A-clear-close-up-photo-of-a-woman.jpg',
    'https://tinyjpg.com/images/social/website.jpg',
    'https://imgv3.fotor.com/images/slider-image/A-clear-close-up-photo-of-a-woman.jpg',
    'https://tinyjpg.com/images/social/website.jpg',
  ];

  int expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200, // Adjust the height according to your needs
                    child: Image.network(
                      imageUrls[expandedIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GridTile(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 100,
                            height: 100,
                            color: Colors.black,
                            child: InkWell(
                              onTap: () => navigateToImagePickScreen(context),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'ADD MORE',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ...List.generate(
                          imageUrls.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                expandedIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 100,
                              height: 100,
                              color:
                                  expandedIndex == index ? Colors.blue : null,
                              child: Image.network(
                                imageUrls[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
