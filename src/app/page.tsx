import { supabase } from '@/lib/supabaseClient';

export default async function Home() {
  const { data: products } = await supabase
    .from('products')
    .select('id, name, image_url')
    .limit(6);

  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold mb-4">Unipro Clothing</h1>
      <div className="grid grid-cols-2 gap-4">
        {products?.map((p) => (
          <div key={p.id} className="border rounded p-2">
            <img src={p.image_url} alt={p.name} className="w-full h-auto" />
            <p className="mt-2 text-center">{p.name}</p>
          </div>
        ))}
      </div>
    </main>
  );
}
