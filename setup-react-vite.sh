#!/bin/bash

#  Get the project name from the argument, default to "bite-react-app"
PROJECT_NAME=${1:-vite-react-app}
REPO_NAME=${2:-repo-name}
USER_NAME=${3:-user-name}

# GitHub Pages URL
HOMEPAGE_URL="https://${USER_NAME}.github.io/${REPO_NAME}/"

# Creat th vite project
echo "Initializing Vite project..."
npm create vite@latest "$PROJECT_NAME" -- --template react

# Move into the project directory
cd "$PROJECT_NAME" || exit

# Install dependencies
echo "Installing dependencies..."
npm install

# Install react-router-dom
echo "Installing react-router-dom..."
npm install react-router-dom

# Install gh-pages
echo "Installing gh-pages for deployment..."
npm install gh-pages --save-dev

# Add homepage into package.json
echo "Setting homepage in package.json..."
jq ".homepage = \"$HOMEPAGE_URL\" | .scripts += {\"predeploy\": \"npm run build\", \"deploy\": \"gh-pages -d dist\"}" package.json > package.tmp && mv package.tmp package.json

# Install Tailwind CSS and its dependencies
echo "Setting up Tailwind CSS..."
npm install -D tailwindcss @tailwindcss/vite postcss autoprefixer
npx tailwindcss init

# Edit config file for Tailwind CSS
echo "Configuring Tailwind CSS..."
cat <<EOL > tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,jsx,ts,tsx,html}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
EOL

# Add Tailwind CSS directives to the main CSS file
echo "Adding Tailwind CSS to main.css..."
cat <<EOL > src/index.css
@import "tailwindcss";
EOL

# Add some plugins to Vite
echo "Configuring Vite to use Tailwind CSS plugin..."
cat <<EOL > vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react(),
    tailwindcss(),
  ],
  base: /"$REPO_NAME"/
})
EOL

# Set up is complete
echo "Project setup complete. To get started:"
echo "cd $PROJECT_NAME"
echo "npm run dev"
