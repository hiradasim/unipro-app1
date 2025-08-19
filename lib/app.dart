import 'package:flutter/material.dart';
import 'main_navigation.dart';

class UniproApp extends StatelessWidget {
  const UniproApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unipro Shop',
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: MainNavigation(),
      ),
    );
  }
}