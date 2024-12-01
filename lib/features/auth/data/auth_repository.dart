import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({
    required this.supabase,
  });

  final SupabaseClient supabase;

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Stream<AuthState> authStateChanges() => supabase.auth.onAuthStateChange;

  Session? get currentSession => supabase.auth.currentSession;

  Future<void> deleteAccount() async {
    await supabase.functions.invoke('delete_user_account');
  }
}

@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    supabase: ref.watch(supabaseClientProvider),
  );
}

@riverpod
Stream<AuthState> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}
