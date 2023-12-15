import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/loader.dart';
import '../../../core/constants/constants.dart';
import '../../../responsive/responsive.dart';
import '../controller/auth_controller.dart';
import 'sign_in_button.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'GENNY A.I.',
        ),
      ),
      body: isLoading
          ? const Loader()
          : Center(
              child: ListView(
                children: [
                  const Column(children: [
                    SizedBox(height: 30),
                  ]),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200.0),
                      child: Image.asset(
                        Constants.login,
                        height: 370,
                      ),
                    ),
                  ),
                  const Responsive(child: SignInButton()),
                ],
              ),
            ),
    );
  }
}
