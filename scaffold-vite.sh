#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Require a project name to prevent accidental default naming
if [ -z "$1" ]; then
  echo "🛑 Error: Please provide a project name."
  echo "Usage: ./scaffold-vite.sh my-new-project"
  exit 1
fi

PROJECT_NAME=$1

# --- Interactive Prompts ---
echo -e "\n========================================"

# Prompt for GitHub username and ensure it is not left blank
while [ -z "$GITHUB_USERNAME" ]; do
  read -p "👤 Enter your GitHub username: " GITHUB_USERNAME
  if [ -z "$GITHUB_USERNAME" ]; then
    echo "   ⚠️ Username is required for package.json and deployment."
  fi
done

read -p "🤔 Do you want to install Supabase? (y/N): " INSTALL_SUPABASE
read -p "🛣️  Do you want to install React Router? (y/N): " INSTALL_ROUTER
read -p "📱 Do you want to configure this as a PWA? (y/N): " INSTALL_PWA
echo -e "========================================\n"

echo "🚀 Bootstrapping Vite + React + Tailwind v4 + GH Actions for '$PROJECT_NAME'..."

# 1. Create the Vite React project
echo -e "\n========================================"
echo "🛑 VITE INTERACTIVE PROMPT INITIATED"
echo "========================================"
echo "1. Linter: Just hit [ENTER] to accept Oxlint."
echo "2. Start Now: Hit [RIGHT ARROW] to select 'No', then [ENTER]."
echo -e "========================================\n"

npm create vite@latest "$PROJECT_NAME" -- --template react
cd "$PROJECT_NAME"

# 2. Install standard dependencies (Added Lucide React!)
echo "📦 Installing standard dependencies..."
npm install lucide-react

# 3. Install Tailwind v4
echo "📦 Installing Tailwind CSS v4..."
npm install -D tailwindcss @tailwindcss/vite


# 3.5 Conditionally Install Extras
if [[ "$INSTALL_SUPABASE" =~ ^[Yy] ]]; then
  echo "📦 Installing Supabase client..."
  npm install @supabase/supabase-js
fi

if [[ "$INSTALL_PWA" =~ ^[Yy] ]]; then
  echo "📦 Installing PWA plugin..."
  npm install -D vite-plugin-pwa
fi

if [[ "$INSTALL_ROUTER" =~ ^[Yy] ]]; then
  echo "📦 Installing React Router..."
  npm install react-router-dom
fi

# 4. Overwrite src/index.css
echo "🎨 Configuring Tailwind..."
cat << EOF > src/index.css
@import "tailwindcss";
EOF

# 5. Build Dynamic App.jsx based on Router choice
echo "✨ Injecting custom App UI..."

if [[ "$INSTALL_ROUTER" =~ ^[Yy] ]]; then
# --- ROUTER VERSION OF APP.JSX ---
cat << 'EOF' > src/App.jsx
import React, { useState } from 'react';
import { HashRouter, Routes, Route, Link } from 'react-router-dom';
import { Activity, Rocket, Info, Home as HomeIcon } from 'lucide-react';

function Home() {
  const [count, setCount] = useState(0);
  const appName = import.meta.env.VITE_APP_NAME || "Vite + React";

  return (
    <div className="relative z-10 text-center">
      <div className="inline-flex items-center justify-center p-2 bg-slate-800 rounded-lg mb-6 border border-slate-700">
        <Activity className="w-4 h-4 text-green-500 animate-pulse mr-2" />
        <span className="text-xs font-mono text-slate-400">SYSTEM ONLINE</span>
      </div>

      <h1 className="text-4xl font-black mb-2 bg-gradient-to-r from-cyan-400 to-violet-500 bg-clip-text text-transparent">
        {appName}
      </h1>
      
      <p className="text-slate-400 mb-8 text-lg">
        Zero config. Maximum speed. <br/>
        <span className="text-sm opacity-50">Tailwind v4 + Vite + GitHub Actions + Router</span>
      </p>

      <button 
        onClick={() => setCount(c => c + 1)}
        className="flex items-center justify-center gap-2 w-full py-3 px-6 bg-white text-slate-950 font-bold rounded-lg transition-all hover:bg-cyan-50 hover:scale-[1.02] active:scale-[0.98] mb-4"
      >
        <Rocket className="w-5 h-5" />
        Deployments Count: {count}
      </button>

      <Link to="/about" className="inline-flex items-center gap-2 text-cyan-400 hover:text-cyan-300 transition-colors">
        <Info className="w-4 h-4" />
        View About Page
      </Link>
    </div>
  );
}

function About() {
  return (
    <div className="relative z-10 text-center">
      <h2 className="text-2xl font-bold mb-4 text-white">About This App</h2>
      <p className="text-slate-400 mb-8">This route was rendered perfectly using HashRouter, which guarantees it will not break when deployed to GitHub Pages.</p>
      <Link to="/" className="inline-flex items-center gap-2 text-violet-400 hover:text-violet-300 transition-colors">
        <HomeIcon className="w-4 h-4" />
        Back to Home
      </Link>
    </div>
  );
}

export default function App() {
  return (
    <div className="min-h-screen bg-slate-950 flex items-center justify-center text-white p-4">
      <div className="bg-slate-900 border border-slate-800 rounded-2xl p-8 max-w-md w-full shadow-2xl relative overflow-hidden">
        <div className="absolute top-0 right-0 -mr-16 -mt-16 w-64 h-64 rounded-full bg-cyan-500 blur-3xl opacity-10 pointer-events-none"></div>
        <div className="absolute bottom-0 left-0 -ml-16 -mb-16 w-64 h-64 rounded-full bg-violet-500 blur-3xl opacity-10 pointer-events-none"></div>
        <HashRouter>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/about" element={<About />} />
          </Routes>
        </HashRouter>
      </div>
    </div>
  );
}
EOF
else
# --- STANDARD VERSION OF APP.JSX ---
cat << 'EOF' > src/App.jsx
import React, { useState } from 'react';
import { Activity, Rocket } from 'lucide-react';

function App() {
  const [count, setCount] = useState(0);
  const appName = import.meta.env.VITE_APP_NAME || "Vite + React";

  return (
    <div className="min-h-screen bg-slate-950 flex items-center justify-center text-white p-4">
      <div className="bg-slate-900 border border-slate-800 rounded-2xl p-8 max-w-md w-full shadow-2xl relative overflow-hidden">
        
        <div className="absolute top-0 right-0 -mr-16 -mt-16 w-64 h-64 rounded-full bg-cyan-500 blur-3xl opacity-10 pointer-events-none"></div>
        <div className="absolute bottom-0 left-0 -ml-16 -mb-16 w-64 h-64 rounded-full bg-violet-500 blur-3xl opacity-10 pointer-events-none"></div>

        <div className="relative z-10 text-center">
          <div className="inline-flex items-center justify-center p-2 bg-slate-800 rounded-lg mb-6 border border-slate-700">
            <Activity className="w-4 h-4 text-green-500 animate-pulse mr-2" />
            <span className="text-xs font-mono text-slate-400">SYSTEM ONLINE</span>
          </div>

          <h1 className="text-4xl font-black mb-2 bg-gradient-to-r from-cyan-400 to-violet-500 bg-clip-text text-transparent">
            {appName}
          </h1>
          
          <p className="text-slate-400 mb-8 text-lg">
            Zero config. Maximum speed. <br/>
            <span className="text-sm opacity-50">Tailwind v4 + Vite + GitHub Actions</span>
          </p>

          <button 
            onClick={() => setCount(c => c + 1)}
            className="flex items-center justify-center gap-2 w-full py-3 px-6 bg-white text-slate-950 font-bold rounded-lg transition-all hover:bg-cyan-50 hover:scale-[1.02] active:scale-[0.98]"
          >
            <Rocket className="w-5 h-5" />
            Deployments Count: {count}
          </button>
        </div>
      </div>
    </div>
  );
}

export default App;
EOF
fi

# 6. Auto-Wire Supabase File
if [[ "$INSTALL_SUPABASE" =~ ^[Yy] ]]; then
  echo "🔌 Auto-wiring Supabase client..."
  mkdir -p src/lib
  cat << 'EOF' > src/lib/supabase.js
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

export const supabase = createClient(supabaseUrl, supabaseAnonKey)
EOF
fi

# 7. Overwrite vite.config.js
echo "⚙️ Configuring Vite plugins and aliases..."

# Setup dynamic PWA variables
PWA_IMPORT=""
PWA_PLUGIN=""
if [[ "$INSTALL_PWA" =~ ^[Yy] ]]; then
  PWA_IMPORT="import { VitePWA } from 'vite-plugin-pwa'"
  PWA_PLUGIN="VitePWA({
      registerType: 'autoUpdate',
      manifest: {
        name: '${PROJECT_NAME}',
        short_name: '${PROJECT_NAME}',
        theme_color: '#0f172a',
        background_color: '#0f172a',
        display: 'standalone',
        icons: [
          { src: 'pwa-192x192.png', sizes: '192x192', type: 'image/png' },
          { src: 'pwa-512x512.png', sizes: '512x512', type: 'image/png' }
        ]
      }
    }),"
fi

cat << EOF > vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import { fileURLToPath, URL } from 'node:url'
${PWA_IMPORT}

export default defineConfig({
  base: '/${PROJECT_NAME}/',
  plugins: [
    react(),
    tailwindcss(),
    ${PWA_PLUGIN}
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    },
  },
})
EOF

# 7.5. Create jsconfig.json
cat << EOF > jsconfig.json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  }
}
EOF

# 8. Update package.json
echo "⚙️ Updating package.json..."
node -e "
const fs = require('fs');
const pkg = JSON.parse(fs.readFileSync('package.json'));
pkg.homepage = 'https://${GITHUB_USERNAME}.github.io/${PROJECT_NAME}/';
fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
"

# 9. Generate Environment Variables
echo "🔐 Setting up environment variables..."
cat << EOF > .env.example
VITE_APP_NAME="${PROJECT_NAME}"
VITE_API_KEY="your_api_key_here"
EOF

cat << EOF > .env.local
VITE_APP_NAME="${PROJECT_NAME}"
VITE_API_KEY="12345"
EOF

if [[ "$INSTALL_SUPABASE" =~ ^[Yy] ]]; then
  cat << EOF >> .env.example
VITE_SUPABASE_URL="your_supabase_url_here"
VITE_SUPABASE_ANON_KEY="your_supabase_anon_key_here"
EOF
  cat << EOF >> .env.local
VITE_SUPABASE_URL="your_supabase_url_here"
VITE_SUPABASE_ANON_KEY="your_supabase_anon_key_here"
EOF
fi

# 10. Set up GitHub Actions
echo "⚙️ Setting up GitHub Actions workflow..."
mkdir -p .github/workflows
cat << EOF > .github/workflows/deploy.yml
name: Deploy to GitHub Pages

on:
  push:
    branches: ["main"]

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Node
        uses: actions/setup-node@v4
        with:
          node-version: "22"
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Build
        run: npm run build
        env:
          VITE_APP_NAME: \${{ secrets.VITE_APP_NAME }}
          VITE_API_KEY: \${{ secrets.VITE_API_KEY }}
$(if [[ "$INSTALL_SUPABASE" =~ ^[Yy] ]]; then
echo "          VITE_SUPABASE_URL: \${{ secrets.VITE_SUPABASE_URL }}"
echo "          VITE_SUPABASE_ANON_KEY: \${{ secrets.VITE_SUPABASE_ANON_KEY }}"
fi)
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: './dist'

  deploy:
    environment:
      name: github-pages
      url: \${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
EOF

# 11. Initialize Git
echo "🔧 Initializing Git..."
git init -b main
git add .
git commit -m "chore: initial setup with Vite, React, Tailwind v4, and GH Actions"

echo "✅ Setup complete! To get started:"
echo "  cd $PROJECT_NAME"
echo "  npm run dev"
echo ""
echo "When you are ready to publish to GitHub Pages:"
echo "  1. Create a remote repository named '$PROJECT_NAME' on GitHub"
echo "  2. git remote add origin https://github.com/${GITHUB_USERNAME}/${PROJECT_NAME}.git"
echo "  3. git push -u origin main"
echo "  4. Configure VITE_APP_NAME and VITE_API_KEY in your GitHub Repo Secrets"
if [[ "$INSTALL_SUPABASE" =~ ^[Yy] ]]; then
  echo "  5. Configure VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY in your GitHub Repo Secrets"
fi
