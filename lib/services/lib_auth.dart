import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supa = Supabase.instance.client;

  Future<void> signIn(String email, String password) async {
    await _supa.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password, {String? fullName}) async {
    final res = await _supa.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
    // optional: create/update profile row after sign up
    if (res.user != null) {
      await _supa.from('profiles').upsert({
        'id': res.user!.id,
        'full_name': fullName,
      });
    }
  }

  Future<void> signOut() => _supa.auth.signOut();

  bool get isLoggedIn => _supa.auth.currentSession != null;

  Stream<AuthState> get authChanges => _supa.auth.onAuthStateChange;
}
