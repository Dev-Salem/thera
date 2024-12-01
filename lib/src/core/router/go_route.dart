import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:thera/src/core/router/refresh_stream.dart';
import 'package:thera/src/features/auth/data/auth_repository.dart';
import 'package:thera/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:thera/src/features/home/presentation/screens/home_screen.dart';
import 'package:thera/src/features/home/presentation/screens/read/book_overview_screen.dart';
import 'package:thera/src/features/home/presentation/screens/read/book_reader.dart';
import 'package:thera/src/features/home/presentation/screens/read/books_grid_screen.dart';
import 'package:thera/src/features/home/presentation/screens/write/chat_screen.dart';
import 'package:thera/src/features/onboarding/screens/onboarding_screens.dart';
import 'package:thera/src/features/user/data/user_repository.dart';

part 'go_route.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);

  return GoRouter(
    initialLocation: "/home",
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    redirect: (context, state) async {
      final path = state.uri.path;
      print(authRepository.currentSession);
      print(userRepository.isFirstSignIn);
      final currentSession = authRepository.currentSession;
      final isFirstSignIn = userRepository.isFirstSignIn;
      // If the user is not signed in
      if (currentSession == null) {
        if (isFirstSignIn && state.uri.path != "/onboarding") {
          return "/onboarding"; // Redirect to onboarding if it's their first sign-in
        }
        if (!isFirstSignIn && state.uri.path != "/signIn") {
          return "/signIn"; // Redirect to sign-in if onboarding is complete
        }
      } else {
        // If the user is signed in
        if (state.uri.path == "/signIn" || state.uri.path == "/onboarding") {
          return "/home"; // Prevent navigating back to sign-in or onboarding
        }
      }

      return null; // No redirection needed
    },
    routes: [
      GoRoute(
        path: "/signIn",
        name: "signIn",
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: "/onboarding",
        name: "onboarding",
        builder: (context, state) => const OnboardingScreens(),
      ),
      GoRoute(
        path: "/home",
        name: "home",
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: "/read",
        name: "read",
        builder: (context, state) => const BookGridScreen(),
      ),
      GoRoute(
        path: "/book/:bookId",
        name: "book",
        builder: (context, state) {
          final bookId = state.pathParameters['bookId']!;
          return BookOverviewScreen(bookId: bookId);
        },
      ),
      GoRoute(
        path: "/read-book/:pdfUrl",
        name: "read-book",
        builder: (context, state) {
          // Decode URL parameter
          final pdfUrl = Uri.decodeComponent(state.pathParameters['pdfUrl']!);
          return PdfReaderScreen(pdfUrl: pdfUrl);
        },
      ),
      GoRoute(
        path: "/write",
        name: "write",
        builder: (context, state) => const ChatScreen(),
      ),
    ],
  );
}
