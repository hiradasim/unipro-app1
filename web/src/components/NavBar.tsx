import Link from 'next/link';

const logoUrl = `${process.env.NEXT_PUBLIC_SUPABASE_URL}/storage/v1/object/public/icons/logo.ico`;

export default function NavBar() {
  return (
    <nav className="flex items-center justify-center gap-4 p-4 bg-white/10 backdrop-blur text-white">
      <img src={logoUrl} alt="logo" className="h-8 w-8" />
      <Link href="/">Home</Link>
      <Link href="/search">Search</Link>
      <Link href="/categories">Categories</Link>
      <Link href="/uniclub">UniClub</Link>
    </nav>
  );
}
