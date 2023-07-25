import { createVuePlugin } from 'vite-plugin-vue2';
import { resolve } from 'path';

export default {
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
  plugins: [createVuePlugin()],
};
