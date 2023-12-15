
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../router.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/repository/auth_repository.dart';
import '../../components/components.dart';
import '../components/settings_components.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool receiveEmails = true,
      newsLetter = false,
      notifyLikes = true,
      notifyComments = true;

  void updateOptions(String option, bool value) async {
    await ref
        .watch(firestoreProvider)
        .collection(FirebaseConstants.usersCollection)
        .doc(ref.watch(userProvider)!.uid)
        .update({option: value});
  }

  @override
  void initState() {
    super.initState();
  }

  List<bool> expansion = [true, true, true];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final auth = ref.watch(AuthRepositoryProvider);
    receiveEmails = user!.receiveEmails;
    newsLetter = user.newsLetter;
    notifyComments = user.notifyComments;
    notifyLikes = user.notifyLikes;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: ListView(
          children: [
            ExpansionPanelList(
              animationDuration: const Duration(milliseconds: 500),
              elevation: 0,
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return const Row(
                      children: [
                        Icon(Icons.notifications_outlined),
                        Text(
                          "Notification",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  },
                  isExpanded: expansion[0],
                  body: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 32) * 0.8,
                            child: const HeadingText(
                              heading:
                                  "Receive emails about latest app updates",
                            ),
                          ),
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 32) * 0.2,
                            height: 8,
                            child: Switch(
                              thumbColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              value: receiveEmails,
                              activeColor: const Color(0x007d87fe),
                              onChanged: (bool value) {
                                setState(() {
                                  receiveEmails = value;
                                });
                                updateOptions("receiveEmails", value);
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 32) * 0.8,
                            child: const HeadingText(
                              heading: "Subscribe to Newsletter",
                            ),
                          ),
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 32) * 0.2,
                            height: 8,
                            child: Switch(
                              thumbColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              value: newsLetter,
                              activeColor: const Color(0x007d87fe),
                              onChanged: (bool value) {
                                setState(() {
                                  newsLetter = value;
                                });
                                updateOptions("newsLetter", value);
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 32) * 0.8,
                            child: const HeadingText(
                              heading: "Get notified about new likes",
                            ),
                          ),
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 32) * 0.2,
                            height: 16,
                            child: Switch(
                              thumbColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              value: notifyLikes,
                              activeColor: const Color(0x007d87fe),
                              onChanged: (bool value) {
                                setState(() {
                                  notifyLikes = value;
                                });
                                updateOptions("notifyLikes", value);
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 32) * 0.8,
                            child: const HeadingText(
                              heading: "Get notified about new comments",
                            ),
                          ),
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 32) * 0.2,
                            height: 16,
                            child: Switch(
                              thumbColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              value: notifyComments,
                              activeColor: const Color(0x007d87fe),
                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  notifyComments = value;
                                });
                                updateOptions("notifyComments", value);
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return const Row(
                      children: [
                        Icon(Icons.star_outline),
                        Text(
                          "Rate and Review",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  },
                  isExpanded: expansion[1],
                  body: const RateReviewExpandedWidget(),
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return const Row(
                      children: [
                        Icon(Icons.support_agent_outlined),
                        Text(
                          "Help and Support",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  },
                  isExpanded: expansion[2],
                  body: const HelpSupportExpandedWidget(),
                ),
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  expansion[item] = !expansion[item];
                });
              },
            ),
            Row(
              children: [
                const Icon(Icons.login, size: 24),
                TextButton(
                  onPressed: () {
                    auth.logOut();
                    navigateTo(context, "/");
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}


