 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a//dev/null b/mobile/lib/pages/home_page.dart
index 0000000000000000000000000000000000000000..5d9edd2d563c28904641a3a45988385ac9f4f361 100644
--- a//dev/null
+++ b/mobile/lib/pages/home_page.dart
@@ -0,0 +1,18 @@
+import 'package:flutter/material.dart';
+import '../widgets/image_grid.dart';
+import '../supabase_client.dart';
+
+class HomePage extends StatelessWidget {
+  const HomePage({super.key});
+
+  @override
+  Widget build(BuildContext context) {
+    return Scaffold(
+      appBar: AppBar(
+        title: const Text('Home'),
+        leading: Image.network(publicIcon('logo.ico')),
+      ),
+      body: const ImageGrid(bucket: 'products'),
+    );
+  }
+}
 
EOF
)
