import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  final List<String> products = ['محصول ۱', 'محصول ۲', 'ویژه', 'کفش', 'لباس'];

  @override
  Widget build(BuildContext context) {
    final filtered = products.where((item) => item.contains(query)).toList();
    return Container(
      decoration: const BoxDecoration(gradient: appGradient),
      child: Column(
        children: [
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: glassCard(
              radius: BorderRadius.circular(32),
              child: TextField(
                onChanged: (value) => setState(() => query = value),
                decoration: const InputDecoration(
                  hintText: 'جستجو...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filtered.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: glassCard(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text(filtered[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
