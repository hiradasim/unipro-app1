import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supa = Supabase.instance.client;

  // ---- Getters used by AuthGate ----
  Stream<AuthState> get authChanges => _supa.auth.onAuthStateChange;
  bool get isLoggedIn => _supa.auth.currentSession != null;

  // ---- Basic auth ----
  Future<void> signIn(String email, String password) async {
    await _supa.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password, {String? fullName}) async {
    final res = await _supa.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
    // Optional profile bootstrap
    if (res.user != null) {
      await _supa.from('profiles').upsert({
        'id': res.user!.id,
        'full_name': fullName,
      });
    }
  }

  Future<void> signOut() => _supa.auth.signOut();

  // ---- Password reset flow ----
  Future<void> sendResetEmail(String email) async {
    await _supa.auth.resetPasswordForEmail(
      email,
      // Make sure this is whitelisted in Supabase Auth settings
      redirectTo: 'io.supabase.flutter://reset-callback',
    );
  }

  Future<void> updatePassword(String newPassword) async {
    await _supa.auth.updateUser(UserAttributes(password: newPassword));
  }
}
