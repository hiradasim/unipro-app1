 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a//dev/null b/mobile/lib/pages/categories_page.dart
index 0000000000000000000000000000000000000000..68b37f0ed415c24ae674faf5fe5cbb16bbdb3e69 100644
--- a//dev/null
+++ b/mobile/lib/pages/categories_page.dart
@@ -0,0 +1,18 @@
+import 'package:flutter/material.dart';
+import '../widgets/image_grid.dart';
+import '../supabase_client.dart';
+
+class CategoriesPage extends StatelessWidget {
+  const CategoriesPage({super.key});
+
+  @override
+  Widget build(BuildContext context) {
+    return Scaffold(
+      appBar: AppBar(
+        title: const Text('Categories'),
+        leading: Image.network(publicIcon('logo.ico')),
+      ),
+      body: const ImageGrid(bucket: 'categories'),
+    );
+  }
+}
 
EOF
)
