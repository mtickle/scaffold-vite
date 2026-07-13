# 🚀 Vite React Scaffolder

A zero-friction, fully automated Bash script to bootstrap production-ready React applications in seconds. 

This script eliminates the tedious manual setup of modern frontend tooling. It bypasses stubborn interactive CLI prompts and instantly wires up a modern, high-performance stack so you can start coding your business logic on minute one.

## ✨ Features

* **Zero-Config Tailwind v4:** Fully integrated with the new `@import "tailwindcss";` syntax.
* **Automated CI/CD:** Generates a ready-to-merge `.github/workflows/deploy.yml` for flawless GitHub Pages deployments.
* **Environment Variable Safety:** Automatically splits `.env.example` and `.env.local` to keep your API keys out of version control.
* **Smart Overrides:** Safely navigates the Vite CLI interactive prompts without breaking your automation flow.
* **Custom UI Injection:** Replaces the default Vite boilerplate with a sleek, dark-mode Tailwind and Lucide React interface.
* **Optional Power-Ups:** Interactive prompts let you selectively install and configure:
  * **React Router:** Pre-configured with `HashRouter` to prevent GitHub Pages 404 errors.
  * **Supabase:** Auto-wires the client SDK and injects your connection keys.
  * **Progressive Web App (PWA):** Installs `vite-plugin-pwa` and generates the manifest for instant mobile installability.

## 📋 Prerequisites

Ensure you have the following installed on your machine:
* **Node.js** (v18 or higher)
* **npm** (v9 or higher)
* **Git**
* **Bash** environment (Linux, macOS, or WSL for Windows)

## 🛠️ Installation

1. Clone or download the script into your dedicated workspace or `Repos` directory.
2. Open the script in your editor and update the configuration variables at the top to match your GitHub username:
   ```bash
   # --- Configuration ---
   GITHUB_USERNAME="your-github-username"
3. Make the script executable:
   ```bash
   chmod +x scaffold-vite.sh

## 🚀 Usage

Run the script and pass your desired project name as the first argument:

### The Setup Flow
Select Options: The script will first ask if you want to include Supabase, React Router, or PWA capabilities.

Bypass the CLI: When Vite initiates its interactive prompt, follow the on-screen cheat code:
1.  Hit [ENTER] to accept Oxlint.
2.  Hit [RIGHT ARROW] then [ENTER] to decline the auto-start.

Stand Back: The script will take back control, install all dependencies, build your configurations, and make your first Git commit.

Once complete, simply step into your new directory and start building:

cd my-new-project
npm run dev

## 🌍 Deployment

Because this script generates a native GitHub Actions workflow, deploying is entirely automated.

Create an empty repository on GitHub matching your project name.

Push your local code to the main branch:   
  ```bash
  git remote add origin https://github.com/yourusername/my-new-project.git
  git branch -M main
  git push -u origin main
