import 'package:flutter/material.dart';
import '../widgets/image_grid.dart';
import '../supabase_client.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        leading: Image.network(publicIcon('logo.ico')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Search'),
              onChanged: (v) => setState(() => query = v),
            ),
          ),
          Expanded(
            child: ImageGrid(bucket: 'products', search: query),
          ),
        ],
      ),
    );
  }
}