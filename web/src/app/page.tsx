import ImageGallery from "@/components/ImageGallery";

export default function Home() {
  return (
    <section className="flex flex-col items-center gap-6">
      <h1 className="text-3xl font-bold">Unipro</h1>
      <ImageGallery bucket="products" />
    </section>
  );
}
