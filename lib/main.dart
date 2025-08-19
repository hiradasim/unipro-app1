import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart'; // for UniproApp
import 'pages/set_new_password_page.dart'; // for SetNewPasswordPage

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  await Hive.openBox('cartBox');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

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
