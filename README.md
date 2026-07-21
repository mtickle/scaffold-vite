# Vite React Scaffolder: Bootstrapping Production-Ready Apps in Seconds

A zero-friction, fully automated Bash script to bootstrap production-ready React applications in seconds. 

This script eliminates the tedious manual setup of modern frontend tooling. It bypasses stubborn interactive CLI prompts and instantly wires up a modern, high-performance stack so you can start coding your business logic on minute one. 

Run it directly in your Repos folder in Linux, or run it on Windows via Git Bash.

## 🛠️ Core Features

* **Zero-Config Tailwind v4:** Fully integrated with the new `@import "tailwindcss";` syntax.
* **Automated CI/CD:** Generates a ready-to-merge `.github/workflows/deploy.yml` for flawless GitHub Pages deployments.
* **Environment Variable Safety:** Automatically splits `.env.example` and `.env.local` to keep your API keys out of version control, and adds placeholder values.
* **Smart Overrides:** Safely navigates the Vite CLI interactive prompts without breaking your automation flow.
* **Custom UI Injection:** Replaces the default Vite boilerplate with a sleek, dark-mode Tailwind and Lucide React interface.

## ⚡ Optional Power-Ups
Interactive prompts let you selectively install and configure:
* **React Router:** Pre-configured with `HashRouter` to prevent GitHub Pages 404 errors.
* **Supabase:** Auto-wires the client SDK and injects your connection keys.
* **Progressive Web App (PWA):** Installs `vite-plugin-pwa` and generates the manifest for instant mobile installability.

## 📋 Prerequisites

Ensure you have the following installed on your machine:
* Node.js (v22 or higher)
* npm (v9 or higher)
* Git
* Bash environment (Linux, macOS, or Git Bash for Windows)

## 🚀 Installation & Usage

**1. Clone or Download**
Save the script into your dedicated workspace or `Repos` directory.

**2. Make it Executable**
```bash
chmod +x scaffold-vite.sh
```

**3. Run the Script**
Pass your desired project name as the first argument:
```bash
./scaffold-vite.sh my-new-project
```

## 🧠 The Setup Flow

1. **Select Options:** The script will first ask for your GitHub username and whether you want to include Supabase, React Router, or PWA capabilities.
2. **Bypass the CLI:** When Vite initiates its interactive prompt, follow the on-screen cheat code:
   * Hit `[ENTER]` to accept Oxlint (or ESLint, whatever floats your boat).
   * Hit `[RIGHT ARROW]` then `[ENTER]` to decline the auto-start. *(THIS IS KEY)*
3. **Stand Back:** The script will take back control, install all dependencies, build your configurations, and make your first Git commit.

Once complete, simply step into your new directory and start building:
```bash
cd my-new-project
npm run dev
```

## 🌍 Automated Deployment

Because this script generates a native GitHub Actions workflow, deploying is entirely automated.

1. Create an empty repository on GitHub matching your project name.
2. Link your local project to the remote repository:
   ```bash
   git remote add origin https://github.com/your-username/my-new-project.git
   ```
3. Push your code to trigger the GitHub Actions workflow:
   ```bash
   git push -u origin main
   ```
4. Configure any `.env` secrets in your GitHub Repo Secrets to finalize your deployment. If you opted into Supabase, be sure to add `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` from your project dashboard.
