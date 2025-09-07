import type { Metadata } from "next";
import "./globals.css";
import NavBar from "@/components/NavBar";

const iconUrl = `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/icons/favicon.ico`;

export const metadata: Metadata = {
  title: "Unipro",
  description: "Clothing brand demo",
  icons: {
    icon: iconUrl,
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="antialiased bg-gradient-to-b from-pink-500 via-purple-500 to-indigo-500 min-h-screen text-white">
        <NavBar />
        <main className="p-4">{children}</main>
      </body>
    </html>
  );
}
