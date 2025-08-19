import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_state.dart';
import 'pages/home_screen.dart';
import 'pages/category_page.dart';
import 'pages/search_page.dart';
import 'pages/cart_page.dart';
import 'pages/likes_page.dart';
import 'widgets/auth_gate.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      CategoryPage(),
      const SearchPage(),
      const AuthGate(), // ⟵ was: LoginPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: cartItemsCount,
                      builder: (context, count, _) => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart_outlined,
                                color: Colors.black),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => CartPage()),
                              );
                              setState(() {});
                            },
                          ),
                          if (count > 0)
                            Positioned(
                              right: 4,
                              top: 4,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                    minWidth: 16, minHeight: 16),
                                child: Center(
                                  child: Text(
                                    '$count',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Unipro',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    ValueListenableBuilder<List<Map<String, String>>>(
                      valueListenable: likedItemsNotifier,
                      builder: (context, liked, _) => IconButton(
                        icon: Icon(
                          liked.isNotEmpty
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LikesPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                showUnselectedLabels: true,
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/home_icon.png', height: 24),
                    activeIcon:
                        Image.asset('assets/home_icon.png', height: 24),
                    label: 'خانه',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/menu_icon.png', height: 24),
                    activeIcon:
                        Image.asset('assets/menu_icon.png', height: 24),
                    label: 'دسته‌بندی',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/search_icon.png', height: 24),
                    activeIcon:
                        Image.asset('assets/search_icon.png', height: 24),
                    label: 'جستجو',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/uniclub_icon.png', height: 24),
                    activeIcon:
                        Image.asset('assets/uniclub_icon.png', height: 24),
                    label: 'یونی‌کلاب',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
