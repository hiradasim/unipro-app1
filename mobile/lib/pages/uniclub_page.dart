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
      appBar: AppBar(
        title: const Text('UniClub'),
        leading: Image.network(publicIcon('logo.ico')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
            if (message != null) ...[
              const SizedBox(height: 12),
              Text(message!),
            ],
          ],
        ),
      ),
    );
  }
}
