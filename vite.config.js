import { resolve } from 'path';
import { createVuePlugin } from 'vite-plugin-vue2';
import compressPlugin from 'vite-plugin-compression';

export default {
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
  plugins: [
    compressPlugin({
      ext: '.gz',
      deleteOriginFile: false, // 是否删除原始文件
    }),
    createVuePlugin(),
  ],
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: '@import "./src/style/var.scss";',
      },
    },
  },
};
