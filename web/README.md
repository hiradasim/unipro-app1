 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a//dev/null b/web/README.md
index 0000000000000000000000000000000000000000..ffce9c38bf34bc8fc52921e9cf8986cbbed445b4 100644
--- a//dev/null
+++ b/web/README.md
@@ -0,0 +1,22 @@
+### Clothing Brand Demo
+
+This Next.js demo loads all product imagery and even the favicon from Supabase storage.
+
+## Getting Started
+
+Create a `.env.local` with your Supabase keys:
+
+```
+NEXT_PUBLIC_SUPABASE_URL=your-url
+NEXT_PUBLIC_SUPABASE_ANON_KEY=your-key
+```
+
+Then run the development server:
+
+```
+npm run dev
+```
+
+## Mobile App
+
+A companion Flutter app lives in the `/mobile` folder. It uses the same Supabase project to fetch images and icons so you can run the experience on a phone.
 
EOF
)
