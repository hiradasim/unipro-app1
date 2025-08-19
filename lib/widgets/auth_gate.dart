import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_services.dart';     // <- correct file name
import '../pages/account_page.dart';
import '../pages/login_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final _auth = AuthService();
  late final Stream<AuthState> _authStream;

  @override
  void initState() {
    super.initState();
    _authStream = _auth.authChanges; // now exists
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: _authStream,
      builder: (context, snapshot) {
        // rely on current session so it works on first build too
        return _auth.isLoggedIn ? const AccountPage() : const LoginPage();
      },
    );
  }
}
