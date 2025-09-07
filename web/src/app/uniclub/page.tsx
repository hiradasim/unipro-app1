"use client";

import { useState } from 'react';

export default function UniClubPage() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  return (
    <section className="flex flex-col items-center gap-4 max-w-sm mx-auto">
      <h1 className="text-2xl font-bold">UniClub</h1>
      <input
        className="p-2 rounded w-full text-black"
        placeholder="username"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
      />
      <input
        type="password"
        className="p-2 rounded w-full text-black"
        placeholder="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />
      <button className="bg-white text-black rounded px-4 py-2">Login</button>
    </section>
  );
}
