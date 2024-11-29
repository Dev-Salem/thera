import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:thera/src/core/router/go_route.dart';
import 'package:thera/src/features/auth/data/auth_repository.dart';
import 'package:thera/src/features/user/data/user_repository.dart';

class OnboardingScreens extends StatelessWidget {
  const OnboardingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return IntroductionScreen(
              pages: [
                PageViewModel(
                  title: "Welcome to Thera!",
                  body:
                      "your personalized journey to mastering English through fun, engaging content!",
                  image:
                      Image.asset("assets/onboarding1.png").paddingOnly(top: 0),
                ),
                PageViewModel(
                  title: "Learn English the effective way!",
                  body:
                      "Daily and atomic listening, reading, writing, and speaking tasks.",
                  image:
                      Image.asset("assets/onboarding2.png").paddingOnly(top: 0),
                ),
                PageViewModel(
                  title:
                      "Daily and atomic listening, reading, writing, and speaking tasks",
                  body: "Stay motivated and track your progress",
                  image:
                      Image.asset("assets/onboarding3.png").paddingOnly(top: 0),
                ),
                PageViewModel(
                  title: "Stay motivated and track your progress",
                  body:
                      "Compete on leaderboards and celebrate your achievements",
                  image: Container(
                      child: Image.asset(
                    "assets/onboarding4.png",
                    fit: BoxFit.fill,
                  ).paddingOnly(top: 0)),
                ),
              ],
              showSkipButton: true,
              showNextButton: true,
              skip: const Text("Skip"),
              done: const Text("Done"),
              next: const Text("Next"),
              onDone: () async {
                final userRepository = ref.read(userRepositoryProvider);
                await userRepository.setIsFirstSignIn(value: false);
                ref.read(goRouterProvider).go("/signIn");
              },
            );
          },
        ),
      ),
    );
  }
}
