import type { Metadata } from "next";
import Link from "next/link";
import "./globals.css";

export const metadata: Metadata = {
  title: "Unipro Clothing",
  description: "Demo clothing brand app",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="antialiased">
        <nav className="p-4 flex gap-4 bg-gray-100">
          <Link href="/">Home</Link>
          <Link href="/search">Search</Link>
          <Link href="/categories">Categories</Link>
          <Link href="/uniclub">UniClub</Link>
        </nav>
        {children}
      </body>
    </html>
  );
}
