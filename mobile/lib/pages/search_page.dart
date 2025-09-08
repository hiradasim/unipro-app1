import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  final _items = ['محصول ۱', 'محصول ۲', 'ویژه', 'کفش', 'لباس'];

  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final results = _items
        .where((e) => e.contains(_filter))
        .toList();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Unipro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'جستجو...'
              ),
              onChanged: (v) => setState(() => _filter = v),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Text(results[i]),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
