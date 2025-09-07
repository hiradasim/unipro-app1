'use client';
import { useState } from 'react';

export default function UniclubPage() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    alert(`Welcome ${username}!`);
  }

  return (
    <main className="p-8 flex flex-col items-center">
      <h1 className="text-xl font-bold mb-4">UniClub</h1>
      <form onSubmit={handleSubmit} className="w-full max-w-xs space-y-4">
        <input
          className="border p-2 w-full"
          placeholder="username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
        <input
          className="border p-2 w-full"
          placeholder="password"
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <button type="submit" className="w-full bg-black text-white p-2 rounded">
          Login
        </button>
      </form>
    </main>
  );
}
