import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thera/src/features/auth/data/auth_repository.dart';
part 'user_repository.g.dart';

class UserRepository {
  UserRepository({required this.supabase, required this.prefs});
  final SharedPreferences prefs;
  final SupabaseClient supabase;

  // Future<void> createUser(String country, String city) async {
  //   final user = entity.User(
  //     country: country,
  //     city: city,
  //     email: supabase.auth.currentUser!.email,
  //   );
  //   await supabase.from(SupabaseConstants.user).upsert(
  //         user.toMap(),
  //         onConflict: 'id',
  //       );
  // }

  // Future<entity.User> getCurrentUser() async {
  //   final user = supabase
  //       .from(SupabaseConstants.user)
  //       .select()
  //       .eq('id', supabase.auth.currentUser!.id)
  //       .withConverter((data) => data.map(entity.User.fromMap).toList().first);
  //   return user;
  // }

  // Future<UserLocation> getUserLocation() async {
  //   final uri = Uri.https(Urls.ipData, '', {
  //     'api-key': Env.ipData,
  //   });
  //   final response = await http.get(uri);
  //   final location = jsonDecode(response.body) as Map<String, dynamic>;
  //   location.infoLogger();
  //   final result = (
  //     countryFlag: location['emoji_flag'] as String,
  //     city: location['city'] as String
  //   );
  //   result.infoLogger();
  //   return result;
  // }

  Future<void> clearLocalStorage() => prefs.clear();

  bool get isFirstSignIn => prefs.getBool('isFirstSignIn') ?? true;

  Future<void> setIsFirstSignIn({required bool value}) async {
    await prefs.setBool('isFirstSignIn', value);
  }
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  return UserRepository(
    supabase: ref.watch(supabaseClientProvider),
    prefs: ref.watch(sharedPreferencesProvider).requireValue,
  );
}

// @Riverpod(keepAlive: true)
// FutureOr<entity.User> currentUser(CurrentUserRef ref) {
//   return ref.watch(userRepositoryProvider).getCurrentUser();
// }

@Riverpod(keepAlive: true)
FutureOr<SharedPreferences> sharedPreferences(Ref ref) async {
  throw UnimplementedError();
}
