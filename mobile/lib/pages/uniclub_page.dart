import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../supabase_client.dart';

class UniClubPage extends StatefulWidget {
  const UniClubPage({super.key});

  @override
  State<UniClubPage> createState() => _UniClubPageState();
}

class _UniClubPageState extends State<UniClubPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? message;

  Future<void> _login() async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: _email.text,
        password: _password.text,
      );
      setState(() =>
          message = res.session != null ? 'Logged in!' : 'No session returned');
    } on AuthException catch (error) {
      setState(() => message = error.message);
    } catch (_) {
      setState(() => message = 'Unexpected error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Unipro'),
      ),
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shield, size: 48),
                const SizedBox(height: 16),
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    labelText: 'username',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    labelText: 'password',
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12)),
                  child: const Text('ورود'),
                ),
                if (message != null) ...[
                  const SizedBox(height: 12),
                  Text(message!),
                ],
                const SizedBox(height: 8),
                const Text('رمز عبور را فراموش کرده‌اید؟'),
                const SizedBox(height: 8),
                const Text('you are, Our Teammate'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
