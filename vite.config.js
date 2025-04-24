import { defineConfig } from 'vite';
import path from 'path';

export default defineConfig({
  server: {
    port: 3000,
  },
  resolve: {
    alias: {
      '/images': path.resolve(__dirname, 'src/images'),
    },
  },
});