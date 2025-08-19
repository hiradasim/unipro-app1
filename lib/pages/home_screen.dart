import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../widgets/banner_slider.dart';
import '../app_state.dart';
import 'product_page.dart';
import 'category_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> categories = [
    {'name': 'زنانه', 'image': 'assets/weman.png'},
    {'name': 'مردانه', 'image': 'assets/men.png'},
    {'name': 'تاپ و نیم تنه', 'image': 'assets/top.webp'},
    {'name': 'لگینگ', 'image': 'assets/leg.webp'},
    {'name': 'شلوارک دخترانه', 'image': 'assets/shortw.webp'},
    {'name': 'تیشرت دخترانه', 'image': 'assets/Tw.webp'},
    {'name': 'آستین بلند زنانه', 'image': 'assets/top.webp'},
    {'name': 'بدون آستین مردانه', 'image': 'assets/SL.webp'},
    {'name': 'تیشرت و پلوشرت مردانه', 'image': 'assets/Tm.webp'},
    {'name': ' شلوار مردانه', 'image': ''},
    {'name': 'شلوارک مردانه', 'image': 'assets/shortm.webp'},
    {'name': 'هودی و سوتشرت', 'image': 'assets/sweet.webp'},
    {'name': 'کاپشن و سوتشرت تمام زیپ', 'image': 'assets/Capshen.webp'},
    {'name': 'شلوار جین زنانه', 'image': ''},
    {'name': 'آینده ها', 'image': ''},
  ];

  final List<Map<String, String>> products = List.generate(
    8,
    (index) => {
      'name': 'محصول ${index + 1}',
      'price': '۲٬۰۰۰٬۰۰۰ تومان',
      'image': 'assets/women_ida_bike_tights_grey.webp',
    },
  );

  final Set<int> _animatingAdd = {};

  bool _isLiked(Map<String, String> product) =>
      likedItemsNotifier.value.any((item) => item['name'] == product['name']);

  void _toggleLike(Map<String, String> product) {
    final current = List<Map<String, String>>.from(likedItemsNotifier.value);
    final existingIndex =
        current.indexWhere((item) => item['name'] == product['name']);
    if (existingIndex >= 0) {
      current.removeAt(existingIndex);
    } else {
      current.add(Map<String, String>.from(product));
    }
    likedItemsNotifier.value = current;
    setState(() {});
  }

  void _addToCart(Map<String, String> product) {
    final item = {
      'name': product['name'] ?? '',
      'price': product['price'] ?? '',
      'image': product['image'] ?? '',
    };
    setState(() {
      cartItems.add(item);
    });
    notifyCartChange();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF2D95), Color(0xFF008CFF)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${item['name']} به سبد اضافه شد',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: appGradient,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const BannerSlider(),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('دسته‌بندی‌ها',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final imagePath = category['image'];
                  final categoryName = category['name'] ?? '';
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CategoryPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 160,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: glassCard(
                            radius: BorderRadius.circular(20),
                            padding: EdgeInsets.zero,
                            child: imagePath != null && imagePath.isNotEmpty
                                ? Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                : Icon(Icons.category_outlined,
                                    size: 40, color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(categoryName),
                    ],
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('پرفروش‌ترین‌ها',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  final liked = _isLiked(product);
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: glassCard(
                      radius: BorderRadius.circular(12),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                product['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(product['name'] ?? ''),
                          const SizedBox(height: 4),
                          Text(product['price'] ?? '',
                              style: TextStyle(color: Colors.green[700])),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => _toggleLike(product),
                                child: Icon(
                                  liked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: liked ? Colors.pink : Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: _animatingAdd.contains(index)
                                    ? null
                                    : () {
                                        _animatingAdd.add(index);
                                        _addToCart(product);
                                        Future.delayed(
                                          const Duration(milliseconds: 700),
                                          () {
                                            _animatingAdd.remove(index);
                                            if (mounted) setState(() {});
                                          },
                                        );
                                      },
                                child: AnimatedScale(
                                  duration: const Duration(milliseconds: 300),
                                  scale:
                                      _animatingAdd.contains(index) ? 1.2 : 1.0,
                                  child: const Icon(Icons.add_shopping_cart),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
