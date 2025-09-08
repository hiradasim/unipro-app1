import 'package:flutter/material.dart';
import '../supabase_client.dart';

class ImageGrid extends StatelessWidget {
  final String bucket;
  final String? search;
  const ImageGrid({super.key, required this.bucket, this.search});

  Future<List<String>> _load() async {
    final storage = supabase.storage.from(bucket);
    final files = await storage.list(path: '');
    final urls = files.map((f) => storage.getPublicUrl(f.name)).toList();
    if (search == null || search!.isEmpty) return urls;
    final query = search!.toLowerCase();
    return urls.where((u) => u.toLowerCase().contains(query)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _load(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final images = snapshot.data!;
        return GridView.count(
          crossAxisCount: 2,
          children: [
            for (final url in images)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image.network(url),
              ),
          ],
        );
      },
    );
  }
}