import 'package:flutter/material.dart';
import 'supabase_client.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/categories_page.dart';
import 'pages/uniclub_page.dart';
import 'widgets/gradient_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  final pages = const [
    HomePage(),
    SearchPage(),
    CategoriesPage(),
    UniClubPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clothing Brand',
      theme: ThemeData(fontFamily: 'Roboto'),
      home: GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: pages[index],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            currentIndex: index,
            onTap: (i) => setState(() => index = i),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'خانه'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'جستجو'),
              BottomNavigationBarItem(icon: Icon(Icons.category), label: 'دسته بندی'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'کلاب'),
            ],
          ),
        ),
      ),
    );
  }
}