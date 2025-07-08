# 🌿 BranchOut

**BranchOut** is a developer-focused platform that connects contributors to open-source projects based on their skills and interests. It enables repository maintainers to highlight projects in need of contributions and helps developers discover meaningful opportunities to contribute.

---

## 🚀 Features

### 🔍 For Contributors

- **Skill-based project recommendations**  
  Get a personalized list of open-source projects that match your technical skills.

- **Detailed project listings**  
  Explore GitHub repositories with information like language, topics, open issues, and more.

- **One-click GitHub access**  
  Go straight to the repository to start exploring or contributing.

---

### 🛠️ For Maintainers

- **OAuth GitHub integration**  
  Securely connect your GitHub account and select repositories you want contributions for.

- **Project syncing**  
  Automatically fetch and store metadata for selected repositories.

- **Background job processing**  
  Background workers manage repo data enrichment and syncs efficiently.

---

## 📦 Tech Stack

- **Backend:** Elixir · Phoenix · Ecto  
- **Frontend:** Phoenix LiveView · TailwindCSS  
- **Auth:** OAuth with GitHub  
- **Data:** PostgreSQL  
- **Background Jobs:** GenServer-based async processing with `DynamicSupervisor`

---

## 🧠 How It Works

1. **User Authentication**  
   Sign in with GitHub to access your repositories and profile.

2. **Skill Selection**  
   Users provide a list of skills they'd like to contribute with.

3. **Repo Selection (for maintainers)**  
   Maintainers choose repositories they want help with — syncing starts automatically.

4. **Recommendation Engine**  
   Developers are matched to repositories based on overlapping skills and project metadata.

---

## 🖼️ Screenshots

> _(Add screenshots here of the dashboard, recommendations view, repo listing modal, etc.)_

---

## 🧪 Local Development

```bash
# Install dependencies
mix deps.get

# Setup database
mix ecto.setup

# Start Phoenix server
mix phx.server
