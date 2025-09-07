import ImageGallery from "@/components/ImageGallery";

export default function CategoriesPage() {
  return (
    <section className="flex flex-col items-center gap-6">
      <h1 className="text-2xl font-bold">Categories</h1>
      <ImageGallery bucket="categories" />
    </section>
  );
}
