import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: appGradient),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final imagePath = category['image'];
            final categoryName = category['name'] ?? '';
            return GestureDetector(
              onTap: () {
                print('Selected $categoryName');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: glassCard(
                  radius: BorderRadius.circular(16),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: imagePath != null && imagePath.isNotEmpty
                              ? Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Container(
                                  color: Colors.white,
                                  child: const Icon(Icons.category_outlined,
                                      size: 40),
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(categoryName),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}