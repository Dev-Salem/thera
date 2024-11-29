import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:thera/src/core/router/refresh_stream.dart';
import 'package:thera/src/features/auth/data/auth_repository.dart';
import 'package:thera/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:thera/src/features/home/presentation/screens/home_screen.dart';
import 'package:thera/src/features/onboarding/screens/onboarding_screens.dart';
import 'package:thera/src/features/user/data/user_repository.dart';
part 'go_route.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return GoRouter(
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      redirect: (context, state) async {
        final currentSession = authRepository.currentSession;
        print(
            "Current Session: $currentSession, isFirstSignIn: ${userRepository.isFirstSignIn}");
        if (currentSession == null) {
          final isFirstSignIn = userRepository.isFirstSignIn;
          if (isFirstSignIn) {
            return "/onboarding";
          }
          return "/signIn";
        }
        return "/home";
      },
      routes: [
        GoRoute(
          path: "/signIn",
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: "/onboarding",
          builder: (context, state) => const OnboardingScreens(),
        ),
        GoRoute(
          path: "/home",
          name: "home",
          builder: (context, state) => const HomeScreen(),
        )
      ]);
}
