
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:routemaster/routemaster.dart';

import '../../../core/common/app_bar.dart';
import '../../../core/common/url_field.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String imageUrl;

  const ImagePreviewScreen({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late Future<http.Response> _imageFuture;
  // int _page = 0;

  @override
  void initState() {
    super.initState();
    _imageFuture = http.get(Uri.parse(widget.imageUrl));
  }

  void navigateToFormScreen(BuildContext context) {
    Routemaster.of(context).push('/form-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'GENNY AI',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  UrlInputField(
                    controller: TextEditingController(text: widget.imageUrl),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 200, // Adjust the height according to your needs
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: FutureBuilder<http.Response>(
                        future: _imageFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData) {
                            return Image.memory(
                              snapshot.data!.bodyBytes,
                              fit: BoxFit.contain,
                            );
                          } else if (snapshot.hasError) {
                            return const Text('Error loading image');
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => navigateToFormScreen(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Proceed'),
                ),
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}
