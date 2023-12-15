import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/constants.dart';
import '../../components/components.dart';

class HelpSupportExpandedWidget extends StatelessWidget {
  const HelpSupportExpandedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.email_outlined),
            SizedBox(width: 8),
            HeadingText(
              heading: "Get notified about new notifyComments",
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.phone_outlined),
            SizedBox(width: 8),
            HeadingText(
              heading: "020-21749372",
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/images/discord.svg"),
              const SizedBox(width: 28),
              SvgPicture.asset("assets/images/linkedin.svg"),
              const SizedBox(width: 28),
              SvgPicture.asset("assets/images/instagram.svg"),
            ],
          ),
        ),
      ],
    );
  }
}

class RateReviewExpandedWidget extends StatelessWidget {
  const RateReviewExpandedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    border: Border.all()),
                padding: const EdgeInsets.all(5),
                height: 60,
                width: 180,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      "assets/images/playstore_icon.svg",
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RATE US ON',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Text(
                          'Google Play',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border: Border.all(),
                ),
                padding: const EdgeInsets.all(5),
                height: 60,
                width: 180,
                child: Row(
                  children: [
                    SizedBox(
                      height: 33,
                      width: 33,
                      child: Image.asset(AssetImages.googleForms),
                    ),
                    const Expanded(
                      child: Text(
                        "Google Forms",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
