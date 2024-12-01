import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thera/core/app_theme.dart';
import 'package:thera/core/env/env.dart';
import 'package:thera/features/auth/data/auth_repository.dart';
import 'package:thera/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:thera/features/home/presentation/screens/home_screen.dart';
import 'package:thera/features/home/presentation/screens/read/book_overview_screen.dart';
import 'package:thera/features/home/presentation/screens/read/books_grid_screen.dart';
import 'package:thera/features/home/presentation/screens/write/chat_screen.dart';
import 'package:thera/features/onboarding/screens/onboarding_screens.dart';
import 'package:thera/features/user/data/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();
  await Supabase.initialize(url: Env.projectUrl, anonKey: Env.anonKey);
  runApp(ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWith((ref) => prefs)],
    child: const App(),
  ));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: _initialRoute(context, ref),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/signIn': (context) => const SignInScreen(),
        '/onboarding': (context) => const OnboardingScreens(),
        "/books": (context) => const BookGridScreen(),
        '/book': (context) => const BookOverviewScreen(bookId: ""),
        '/write': (context) => const ChatScreen(),
      },
    );
  }
}

String _initialRoute(BuildContext context, WidgetRef ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final userRepository = ref.read(userRepositoryProvider);
  final currentSession = authRepository.currentSession;

  if (currentSession == null) {
    if (userRepository.isFirstSignIn) {
      return '/onboarding'; // First sign-in: Show onboarding
    } else {
      return '/signIn'; // Otherwise, show sign-in
    }
  }
  return '/home'; // If already signed in, show home
}
