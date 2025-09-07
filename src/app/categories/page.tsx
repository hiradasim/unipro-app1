import { supabase } from '@/lib/supabaseClient';

export default async function CategoriesPage() {
  const { data: categories } = await supabase
    .from('categories')
    .select('id, name, image_url');

  return (
    <main className="p-8">
      <h1 className="text-xl font-bold mb-4">Categories</h1>
      <div className="grid grid-cols-2 gap-4">
        {categories?.map((c) => (
          <div key={c.id} className="border rounded p-4 text-center">
            <img
              src={c.image_url}
              alt={c.name}
              className="w-full h-32 object-cover mb-2"
            />
            <p>{c.name}</p>
          </div>
        ))}
      </div>
    </main>
  );
}
