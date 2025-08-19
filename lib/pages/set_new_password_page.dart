import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class SetNewPasswordPage extends StatefulWidget {
  const SetNewPasswordPage({super.key});

  @override
  State<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  final _pass1 = TextEditingController();
  final _pass2 = TextEditingController();
  final _auth = AuthService();
  bool _loading = false;

  @override
  void dispose() { _pass1.dispose(); _pass2.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_pass1.text != _pass2.text || _pass1.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('رمزها یکسان نیستند')),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      await _auth.updatePassword(_pass1.text.trim());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('رمز عبور با موفقیت تغییر کرد')),
      );
      Navigator.pop(context); // back to login/account
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطا: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعیین رمز جدید')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(obscureText: true, controller: _pass1, decoration: const InputDecoration(labelText: 'رمز جدید')),
            const SizedBox(height: 12),
            TextField(obscureText: true, controller: _pass2, decoration: const InputDecoration(labelText: 'تکرار رمز جدید')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _loading ? null : _submit, child: const Text('ثبت')),
          ],
        ),
      ),
    );
  }
}
