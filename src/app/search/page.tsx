'use client';
import { useState } from 'react';
import { supabase } from '@/lib/supabaseClient';

type Product = { id: number; name: string; image_url: string };

export default function SearchPage() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<Product[]>([]);

  async function handleSearch(e: React.FormEvent) {
    e.preventDefault();
    const { data } = await supabase
      .from('products')
      .select('id, name, image_url')
      .ilike('name', `%${query}%`);
    setResults((data as Product[]) ?? []);
  }

  return (
    <main className="p-8">
      <h1 className="text-xl font-bold mb-4">Search</h1>
      <form onSubmit={handleSearch} className="mb-4 flex gap-2">
        <input
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          className="border p-2 flex-1"
          placeholder="Search..."
        />
        <button type="submit" className="px-4 py-2 bg-black text-white rounded">
          Go
        </button>
      </form>
      <div className="grid grid-cols-2 gap-4">
        {results.map((p) => (
          <div key={p.id} className="border rounded p-2">
            <img src={p.image_url} alt={p.name} className="w-full h-auto" />
            <p className="mt-2 text-center">{p.name}</p>
          </div>
        ))}
      </div>
    </main>
  );
}
