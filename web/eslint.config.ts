 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a//dev/null b/web/eslint.config.mjs
index 0000000000000000000000000000000000000000..719cea2b59f3222f4830a756100e1f756b8a18af 100644
--- a//dev/null
+++ b/web/eslint.config.mjs
@@ -0,0 +1,25 @@
+import { dirname } from "path";
+import { fileURLToPath } from "url";
+import { FlatCompat } from "@eslint/eslintrc";
+
+const __filename = fileURLToPath(import.meta.url);
+const __dirname = dirname(__filename);
+
+const compat = new FlatCompat({
+  baseDirectory: __dirname,
+});
+
+const eslintConfig = [
+  ...compat.extends("next/core-web-vitals", "next/typescript"),
+  {
+    ignores: [
+      "node_modules/**",
+      ".next/**",
+      "out/**",
+      "build/**",
+      "next-env.d.ts",
+    ],
+  },
+];
+
+export default eslintConfig;
 
EOF
)
