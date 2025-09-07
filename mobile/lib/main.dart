 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a//dev/null b/mobile/lib/main.dart
index 0000000000000000000000000000000000000000..e85a83dedf0d3521121a01054ccc00bc12ed8f84 100644
--- a//dev/null
+++ b/mobile/lib/main.dart
@@ -0,0 +1,50 @@
+import 'package:flutter/material.dart';
+import 'supabase_client.dart';
+import 'pages/home_page.dart';
+import 'pages/search_page.dart';
+import 'pages/categories_page.dart';
+import 'pages/uniclub_page.dart';
+
+void main() async {
+  WidgetsFlutterBinding.ensureInitialized();
+  await initSupabase();
+  runApp(const MyApp());
+}
+
+class MyApp extends StatefulWidget {
+  const MyApp({super.key});
+
+  @override
+  State<MyApp> createState() => _MyAppState();
+}
+
+class _MyAppState extends State<MyApp> {
+  int index = 0;
+  final pages = const [
+    HomePage(),
+    SearchPage(),
+    CategoriesPage(),
+    UniClubPage(),
+  ];
+
+  @override
+  Widget build(BuildContext context) {
+    return MaterialApp(
+      title: 'Clothing Brand',
+      theme: ThemeData(primarySwatch: Colors.blue),
+      home: Scaffold(
+        body: pages[index],
+        bottomNavigationBar: BottomNavigationBar(
+          currentIndex: index,
+          onTap: (i) => setState(() => index = i),
+          items: const [
+            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
+            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
+            BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
+            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'UniClub'),
+          ],
+        ),
+      ),
+    );
+  }
+}
 
EOF
)
