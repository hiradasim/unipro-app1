import 'package:flutter/material.dart';
import '../app_state.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({super.key});

  @override
  State<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('علاقه‌مندی‌ها')),
      body: likedItemsNotifier.value.isEmpty
          ? const Center(child: Text('محصولی پسندیده نشده است'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: likedItemsNotifier.value.length,
              itemBuilder: (context, index) {
                final item = likedItemsNotifier.value[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: item['image'] != null && item['image']!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item['image']!,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox(width: 56, height: 56),
                    title: Text(item['name'] ?? ''),
                    subtitle: Text(item['price'] ?? ''),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          final current =
                              List<Map<String, String>>.from(likedItemsNotifier.value);
                          current.removeAt(index);
                          likedItemsNotifier.value = current;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}