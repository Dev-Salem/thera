import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:thera/src/core/router/refresh_stream.dart';
import 'package:thera/src/features/auth/data/auth_repository.dart';
import 'package:thera/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:thera/src/features/home/domain/book.dart';
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
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      redirect: (context, state) async {
        final path = state.uri.path;
        final currentSession = authRepository.currentSession;
        print(
            "is First sign in${userRepository.isFirstSignIn}\nCurrent session: ${currentSession?.user}");
        if (currentSession == null) {
          final isFirstSignIn = userRepository.isFirstSignIn;
          if (isFirstSignIn) {
            return "/onboarding";
          } else {
            if (path.startsWith('/signIn')) {
              return "/home";
            }
          }
        }
        return null;
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
          path: "/book",
          name: "book",
          builder: (context, state) => BookOverviewScreen(
            book: state.extra as Book,
          ),
        ),
        GoRoute(
            path: "/read-book",
            name: "read-book",
            builder: (context, state) =>
                PdfReaderScreen(pdfUrl: state.extra as String)),
        GoRoute(
            path: "/write",
            name: "write",
            builder: (context, state) => const ChatScreen())
      ]);
}
