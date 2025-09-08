import 'package:flutter/material.dart';

/// Home screen showing banner, categories and best seller grid.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final _banners = [
    'https://images.unsplash.com/photo-1558769132-92a7f9b5e16d?w=800',
    'https://images.unsplash.com/photo-1523381210434-271e8be1f52f?w=800',
  ];

  static final _categories = [
    {
      'title': 'زنانه',
      'image':
          'https://images.unsplash.com/photo-1519741497674-611481863552?w=400'
    },
    {
      'title': 'مردانه',
      'image':
          'https://images.unsplash.com/photo-1602810318383-e651a92a8376?w=400'
    },
  ];

  static final _bestSellers = [
    'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400',
    'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?w=400',
    'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=400',
    'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=400',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 160,
            child: PageView(
              children: [
                for (final url in _banners)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(url, fit: BoxFit.cover),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'دسته بندی ها',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, i) {
                final cat = _categories[i];
                return Container(
                  width: 150,
                  margin: EdgeInsets.only(right: i == 0 ? 0 : 12),
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
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'پرفروش ترین ها',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
            children: [
              for (final url in _bestSellers)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(url, fit: BoxFit.cover),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
