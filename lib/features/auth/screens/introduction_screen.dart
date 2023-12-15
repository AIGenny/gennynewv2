
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';
import 'sign_in_button.dart';

class IntroductionScreen extends ConsumerStatefulWidget {
  const IntroductionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IntroductionScreenState();
}

class _IntroductionScreenState extends ConsumerState<IntroductionScreen> {
  int introSeq = 0;
  List<String> images = [
    "assets/images/login0.png",
    "assets/images/login2.png",
    "assets/images/login3.png"
  ];
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Genny",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(images[introSeq]),
                    const SizedBox(height: 35),
                    if (introSeq < 2)
                      Text(
                        introSeq == 0
                            ? "Curate Your Signature Collection!"
                            : "Share Your Outfits With Others",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    if (introSeq < 2) const SizedBox(height: 21),
                    if (introSeq < 2)
                      Text(
                        introSeq == 0
                            ? "Effortlessly add your own outfits from your gallery and curate a one-of-a-kind collection that reflects your individuality."
                            : "Here you can showcase your personal style like never before. You can effortlessly add your own outfits from your gallery and curate a one-of-a-kind collection that reflects your individuality.",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0x98989898)),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 60),
                    if (introSeq == 2) const SizedBox(height: 60),
                    if (introSeq == 2)
                      const Text(
                        "Use your Google Account to LogIn or SignUp!",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
        child: introSeq == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      backgroundColor: Colors.white,
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff7d87fe),
                      ),
                    ),
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      backgroundColor: const Color(0xff7d87fe),
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: () {
                      setState(() {
                        introSeq++;
                      });
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            : introSeq == 1
                ? TextButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      backgroundColor: const Color(0xff7d87fe),
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: () {
                      setState(() {
                        introSeq++;
                      });
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  )
                : SignInButton(),
        // TextButton(
        //     style: ElevatedButton.styleFrom(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(11),
        //       ),
        //       backgroundColor: const Color(0xff7d87fe),
        //       minimumSize: const Size(150, 50),
        //     ),
        //     onPressed: () {
        //       if (introSeq < 2) {
        //         setState(() {
        //           introSeq++;
        //         });
        //       }
        //     },
        //     child: const Text(
        //       'Login/Sign Up With Google',
        //       style: TextStyle(
        //         fontWeight: FontWeight.w600,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
      ),
    );
  }
}

class DecorContainer extends StatelessWidget {
  const DecorContainer({
    super.key,
    required this.width,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: width,
      decoration: const BoxDecoration(
          color: Color(0xff7d87fe),
          borderRadius: BorderRadius.all(Radius.circular(50))),
    );
  }
}
