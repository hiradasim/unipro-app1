 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a//dev/null b/mobile/lib/supabase_client.dart
index 0000000000000000000000000000000000000000..4a8d825f3c06968aec78b164d93e8909a905f898 100644
--- a//dev/null
+++ b/mobile/lib/supabase_client.dart
@@ -0,0 +1,23 @@
+import 'package:supabase_flutter/supabase_flutter.dart';
+
+const supabaseUrl = String.fromEnvironment(
+  'SUPABASE_URL',
+  defaultValue: 'https://bqdmfruhqvhpscyswkgl.supabase.co',
+);
+const supabaseAnonKey = String.fromEnvironment(
+  'SUPABASE_ANON_KEY',
+  defaultValue:
+      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJxZG1mcnVocXZocHNjeXN3a2dsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ2NTc3NDAsImV4cCI6MjA3MDIzMzc0MH0.J9pex12Hq6DT7KgdNFbafeK3-enDgbFI_m4A2y7pX7M',
+);
+
+Future<void> initSupabase() async {
+  await Supabase.initialize(
+    url: supabaseUrl,
+    anonKey: supabaseAnonKey,
+  );
+}
+
+final supabase = Supabase.instance.client;
+
+String publicIcon(String name) =>
+    '$supabaseUrl/storage/v1/object/public/icons/$name';
 
EOF
)
