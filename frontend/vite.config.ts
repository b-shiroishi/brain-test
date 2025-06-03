import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    outDir: 'dist',
    emptyOutDir: true,  // ビルド前にディレクトリを完全にクリア
    sourcemap: false
  },
  // 開発時のキャッシュ設定
  optimizeDeps: {
    force: true  // 依存関係の最適化を強制
  }
})