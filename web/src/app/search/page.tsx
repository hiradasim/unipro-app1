"use client";

import { useState } from 'react';
import ImageGallery from "@/components/ImageGallery";

export default function SearchPage() {
  const [query, setQuery] = useState("");

  return (
    <section className="flex flex-col items-center gap-4">
      <input
        className="p-2 rounded text-black"
        placeholder="Search..."
        value={query}
        onChange={(e) => setQuery(e.target.value)}
      />
      <ImageGallery bucket="products" search={query} />
    </section>
  );
}
