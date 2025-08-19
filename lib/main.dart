import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart'; // for UniproApp
import 'pages/set_new_password_page.dart'; // for SetNewPasswordPage

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bqdmfruhqvhpscyswkgl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJxZG1mcnVocXZocHNjeXN3a2dsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ2NTc3NDAsImV4cCI6MjA3MDIzMzc0MH0.J9pex12Hq6DT7KgdNFbafeK3-enDgbFI_m4A2y7pX7M',
  );

  // Listen for password recovery links
  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    if (data.event == AuthChangeEvent.passwordRecovery) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => const SetNewPasswordPage()),
        );
      });
    }
  });

  runApp(const UniproApp());
}
