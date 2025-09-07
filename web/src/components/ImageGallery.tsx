"use client";

import { useEffect, useState } from 'react';
import Image from 'next/image';
import { supabase } from '@/lib/supabaseClient';

type Props = {
  bucket: string;
  search?: string;
};

export default function ImageGallery({ bucket, search = '' }: Props) {
  const [images, setImages] = useState<string[]>([]);

  useEffect(() => {
    async function load() {
      const { data, error } = await supabase.storage.from(bucket).list();
      if (error || !data) {
        console.error(error);
        return;
      }
      const filtered = data.filter((file) =>
        file.name.toLowerCase().includes(search.toLowerCase())
      );
      const urls = filtered.map(
        (file) =>
          supabase.storage.from(bucket).getPublicUrl(file.name).data.publicUrl
      );
      setImages(urls);
    }
    load();
  }, [bucket, search]);

  return (
    <div className="grid grid-cols-2 gap-4">
      {images.map((url) => (
        <Image
          key={url}
          src={url}
          alt=""
          width={200}
          height={200}
          className="rounded object-cover"
        />
      ))}
    </div>
  );
}
