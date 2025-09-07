# Unipro Clothing App

This is a simple Next.js demo for a clothing brand. It includes:

- **Home** page showing featured products pulled from Supabase
- **Search** page with client-side search against Supabase data
- **Categories** page listing product categories
- **UniClub** page with a basic login form

Images and data are loaded from Supabase using the provided public URL and key.
No local image assets are bundled with the app; all pictures are fetched directly
from the Supabase host.

## Setup

1. Ensure the `.env.local` file contains your Supabase credentials.
2. Install dependencies:
   ```bash
   npm install
   ```
3. Run the development server:
   ```bash
   npm run dev
   ```
4. Open [http://localhost:3000](http://localhost:3000) in your browser.

The app uses Next.js with the App Router and Tailwind CSS.
