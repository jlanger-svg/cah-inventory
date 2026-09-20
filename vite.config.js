import { defineConfig } from 'vite';

export default defineConfig({
  define: {
    'import.meta.env.VITE_SUPABASE_URL': JSON.stringify('https://awloyxboctvggdjnpdji.supabase.co'),
    'import.meta.env.VITE_SUPABASE_ANON_KEY': JSON.stringify('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF3bG95eGJvY3R2Z2dkam5wZGppIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODk4MzA3NTYsImV4cCI6MjEwNTQwNjc1Nn0.vSuVhG4AiDRciH36qw5jGs-Zeql2_ReSMyGUtgiVNyc')
  }
});
