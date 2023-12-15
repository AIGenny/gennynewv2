import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BulletList extends StatelessWidget {
  final List<Map<String, String>> strings;

  BulletList(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: RichText(
                text: TextSpan(
                    text: "${str["heading"]}: ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'Poppins'
                    ),
                    children: [
                      TextSpan(
                        text: str["content"],
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      )
                    ]),
              )
                  // Text(
                  //   str,
                  //   textAlign: TextAlign.left,
                  //   softWrap: true,
                  // ),
                  ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Genny",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ABOUT US",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  Text(
                    "Jenny, your personal digital wardrobe where style meets community! With Jenny, you can effortlessly curate a stunning collection of your outfits by simply choosing images",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 38),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ROADMAP",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  const Text(
                    "Our Roadmap is filled with exciting plans and future enhancements for Jenny, designed to elevate your fashion experience.",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  BulletList(const [
                    {
                      "heading": "Enhanced Wardrobe Organization",
                      "content":
                          "We're working on introducing advanced categorization options, allowing you to organize your digital wardrobe with even more precision. Expect tags, filters, and personalized sorting options to e"
                    }
                  ])
                ],
              ),
            ),
            const SizedBox(height: 38),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "JOBS",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  Text(
                    "Our Roadmap is filled with exciting plans and future enhancements for Jenny, designed to elevate your fashion experience.",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
