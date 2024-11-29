import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thera/src/app.dart';
import 'package:thera/src/core/app_theme.dart';
import 'package:thera/src/core/env/env.dart';
import 'package:thera/src/core/router/go_route.dart';
import 'package:thera/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:thera/src/features/onboarding/screens/onboarding_screens.dart';
import 'package:thera/src/features/user/data/user_repository.dart';

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: ref.watch(goRouterProvider),
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
    );
  }
}
