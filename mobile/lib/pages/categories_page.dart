import 'package:flutter/material.dart';
import '../widgets/image_grid.dart';
import '../supabase_client.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        leading: Image.network(publicIcon('logo.ico')),
      ),
      body: const ImageGrid(bucket: 'categories'),
    );
  }
}