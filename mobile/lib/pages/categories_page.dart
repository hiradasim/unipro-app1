import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  static final _categories = [
    {
      'title': 'مردانه',
      'image':
          'https://images.unsplash.com/photo-1528701800489-20be7c3873f2?w=400'
    },
    {
      'title': 'زنانه',
      'image':
          'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?w=400'
    },
    {
      'title': 'تاپ و نیم تنه',
      'image':
          'https://images.unsplash.com/photo-1520974741684-85d155c4aaf5?w=400'
    },
    {
      'title': 'شلوار دخترانه',
      'image':
          'https://images.unsplash.com/photo-1522336572468-97b06e8ef143?w=400'
    },
    {
      'title': 'تی شرت دخترانه',
      'image':
          'https://images.unsplash.com/photo-1514996937319-344454492b37?w=400'
    },
    {
      'title': 'لگینگ',
      'image':
          'https://images.unsplash.com/photo-1516815231560-8f7e1e18f4dd?w=400'
    },
  ];

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
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
        children: [
          for (final cat in _categories)
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(cat['image']!, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(cat['title']!),
                  const SizedBox(height: 8),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
