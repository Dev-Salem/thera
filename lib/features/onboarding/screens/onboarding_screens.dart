import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thera/core/router/go_route.dart';
import 'package:thera/features/onboarding/widgets/customize_plan_widget.dart';
import 'package:thera/features/onboarding/widgets/level_selector_widget.dart';
import 'package:thera/features/user/data/user_repository.dart';

class OnboardingScreens extends ConsumerWidget {
  const OnboardingScreens({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'تسجيل',
        trailing: const Text('تسجيل الدخول'),
        indicatorAbove: true,
        centerBackground: true,
        onFinish: () async {
          final userRepository = ref.read(userRepositoryProvider);
          await userRepository.setIsFirstSignIn(value: false);
          Navigator.of(context).pushNamed("/signIn");
        },
        background: [
          Image.asset('assets/onboarding1.png'),
          Image.asset('assets/onboarding2.png'),
          Image.asset('assets/onboarding3.png'),
          Image.asset('assets/onboarding4.png'),
          const SizedBox(),
          const SizedBox()
        ],
        totalPage: 6,
        speed: 1.8,
        pageBodies: [
          ...List.generate(4, (index) {
            return Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      onboardingTexts[index].$1,
                      textAlign: TextAlign.center,
                      style: context.titleLarge,
                    ),
                    8.heightBox,
                    Text(
                      onboardingTexts[index].$2,
                      textAlign: TextAlign.center,
                      style: context.titleMedium,
                    ),
                  ],
                ));
          }),
          const LanguageLevelSelector(),
          const CustomizePlanScreen()
        ],
      ),
    );
  }
}

List<(String title, String subtitle)> onboardingTexts = [
  (
    "!مرحبًا بك في ذرة",
    "رحلتك الشخصية لإتقان العربية من خلال محتوى ممتع وجذاب!"
  ),
  (
    "تعلم العربية بطريقة فعالة",
    "استكشف قصصًا، وبودكاست، ومقالات تناسب مستواك واهتماماتك"
  ),
  (
    "اختر مستواك وحدد مهام يومية تناسبك.",
    "مهام يومية مصغرة للاستماع، والقراءة، والكتابة، والتحدث"
  ),
  (
    "مهام يومية مصغرة للاستماع، والقراءة، والكتابة، والتحدث",
    "نافس على لوحات الصدارة واحتفل بإنجازاتك"
  ),
];
