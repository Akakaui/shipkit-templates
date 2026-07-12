---
name: open-design
description: Design web pages, landing pages, dashboards, mobile screens, carousels, and any visual layout using Open Design. Create projects, write HTML/CSS/JSX files directly, spawn AI to generate full designs, search and manage design artifacts. Use when asked to "design a page", "build a landing page", "create a website", "design a dashboard", "make a carousel", "design a mobile screen", or any visual design task. Requires Open Design MCP server.
metadata:
  mcp-server: open-design
  version: "1.0.0"
---

# Open Design — Design Any Visual Layout with AI

Open Design is a local-first design workspace. You create artifacts (HTML/CSS/JSX/SVG) inside projects, manage files, and spawn an AI agent to generate full designs on command.

## Setup

Open Design MCP server must be configured in `~/.config/opencode/opencode.json`:

```json
{
  "mcp": {
    "open-design": {
      "type": "local",
      "command": ["/usr/bin/node", "/home/ubuntu/open-design/apps/daemon/dist/cli.js", "mcp"],
      "environment": {
        "OD_DATA_DIR": "/home/ubuntu/open-design/.od",
        "OD_SIDECAR_IPC_PATH": "/tmp/open-design/ipc/default/daemon.sock"
      }
    }
  }
}
```

The Open Design daemon must be running on the same VPS.

## Available MCP Tools

| Tool | Purpose | When to use |
|---|---|---|
| `create_project` | Start a new design project | First step for any new design |
| `write_file` | Create/edit HTML, CSS, JSX, SVG, JSON, Markdown | Build and iterate on designs |
| `create_artifact` | Create entry file with manifest | When creating a new design entry point |
| `list_projects` | See all projects | Check existing work |
| `get_project` | Project metadata + preview URL | Get details on a specific project |
| `list_files` | List all files in a project | See what's been built |
| `get_file` | Read one file | Inspect existing code |
| `get_artifact` | Bundle entry + all referenced siblings | Get full context of a design |
| `search_files` | Search across all project files | Find patterns, components, code |
| `delete_file` | Remove a file | Clean up |
| `delete_project` | Remove entire project | Full cleanup (requires confirm:true) |
| `start_run` | Spawn AI agent to generate designs | Let Open Design's AI build full pages |
| `get_run` | Poll a run's progress | Monitor generation |
| `cancel_run` | Cancel a run | Stop in-progress generation |
| `list_agents` | List available AI agents | See what agents can run |
| `list_skills` | List design skills | Discover available recipes |
| `list_plugins` | List design plugins | Discover packaged workflows |

## Core Workflow

### 1. Create a project

```
create_project(name: "my-landing-page")
```

Returns project ID and conversation ID.

### 2. Write design files

Use `write_file` to create HTML/CSS/JSX directly:

```
write_file(
  project: "<project-id>",
  path: "index.html",
  content: "<!DOCTYPE html>..."
)
```

### 3. Read and iterate

```
get_file(project: "<project-id>", path: "index.html")
list_files(project: "<project-id>")
search_files(project: "<project-id>", query: "button")
```

### 4. Let AI generate for you

```
start_run(
  project: "<project-id>",
  prompt: "Design a modern SaaS pricing page with 3 tiers, dark theme, gradient accents",
  agent: "opencode"
)
```

Poll with `get_run` until status is `succeeded`. Then use `get_artifact` to pull the result.

### 5. Clean up

```
delete_file(project: "<project-id>", path: "old-file.html")
delete_project(project: "<project-id>", confirm: true)
```

## Design Patterns

### Landing Page Structure

1. **Hero** — large heading, subtext, primary CTA, hero image/illustration
2. **Social proof** — logo cloud or testimonial
3. **Features/benefits** — 3-column grid with icons + descriptions
4. **How it works** — numbered steps or timeline
5. **Pricing** — 3 tiers, highlight featured plan
6. **FAQ** — accordion or stacked Q&A
7. **CTA** — final call to action with strong contrast
8. **Footer** — links, copyright, minimal

### Color System

**Dark theme (preferred for modern designs):**
- Background: `#0D1B2A` or `#111827`
- Surface cards: `rgba(255,255,255,0.06)` with subtle borders
- Primary text: `#ffffff`
- Secondary text: `rgba(255,255,255,0.7)`
- Accent colors: brand-specific (yellow, coral, teal, blue)

**Light theme:**
- Background: `#ffffff` or `#f9fafb`
- Surface cards: `#ffffff` with `box-shadow: 0 1px 3px rgba(0,0,0,0.1)`
- Primary text: `#111827`
- Secondary text: `#6b7280`

### Typography Scale

- Hero: 64-72px, weight 900
- H2: 48-56px, weight 900
- H3: 24-28px, weight 700
- Body: 16-18px, weight 400
- Small: 14px, weight 400

Use Inter, Geist, or system fonts. Max 2 font families.

### Spacing

- Section padding: `80px 80px` (desktop), `40px 24px` (mobile)
- Card padding: `32-40px`
- Element gap: `24-32px`
- Max content width: `1200px` centered

### Responsive Breakpoints

- Mobile: `< 640px` — single column, stacked
- Tablet: `640-1024px` — 2 columns where appropriate
- Desktop: `> 1024px` — full layout

## Combining with Image Generation

Open Design handles layout and structure. For custom illustrations:

1. Generate images via OpenRouter API (once credits added)
2. Save to project directory
3. Reference in HTML with `<img src="path/to/image.png">`

Or use `write_file` to create SVG illustrations inline.

## Example: Full Landing Page

```html
<!DOCTYPE html>
<html lang="de">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MutWerk</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: "Inter", sans-serif; background: #0D1B2A; color: white; }
    nav { display: flex; justify-content: space-between; align-items: center; padding: 24px 80px; }
    .logo { font-size: 28px; font-weight: 900; }
    .logo span { color: #FFB800; }
    .nav-links { display: flex; gap: 32px; }
    .nav-links a { color: rgba(255,255,255,0.8); text-decoration: none; font-weight: 600; }
    .hero { min-height: 100vh; display: flex; align-items: center; padding: 80px; gap: 80px; }
    .hero-text { flex: 1; }
    .hero-text h1 { font-size: 72px; font-weight: 900; line-height: 1.05; margin-bottom: 24px; }
    .hero-text h1 em { font-style: normal; color: #FFB800; }
    .hero-text p { font-size: 22px; color: rgba(255,255,255,0.75); line-height: 1.6; margin-bottom: 40px; max-width: 500px; }
    .btn { display: inline-block; background: #FFB800; color: #0D1B2A; font-size: 16px; font-weight: 700; padding: 16px 40px; border-radius: 50px; text-decoration: none; }
    .hero-img { flex: 1; height: 500px; background: rgba(255,255,255,0.05); border: 2px dashed rgba(255,255,255,0.2); border-radius: 16px; display: flex; align-items: center; justify-content: center; color: rgba(255,255,255,0.4); }
    .programs { padding: 120px 80px; }
    .programs h2 { font-size: 56px; font-weight: 900; margin-bottom: 48px; }
    .grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 32px; }
    .card { background: rgba(255,255,255,0.06); border-radius: 16px; padding: 40px; border-left: 4px solid #FFB800; }
    .card h3 { font-size: 24px; margin-bottom: 12px; }
    .card p { color: rgba(255,255,255,0.7); line-height: 1.6; }
    .card:nth-child(2) { border-color: #FF6B6B; }
    .card:nth-child(3) { border-color: #4ECDC4; }
    .cta { text-align: center; padding: 120px 80px; background: linear-gradient(135deg, #FFB800, #FF6B6B, #4ECDC4); }
    .cta h2 { color: #0D1B2A; font-size: 64px; font-weight: 900; margin-bottom: 16px; }
    .cta p { color: rgba(13,27,42,0.8); font-size: 22px; margin-bottom: 40px; }
    .cta .btn-dark { background: #0D1B2A; color: white; }
  </style>
</head>
<body>
  <nav>
    <div class="logo">MUT<span>WERK</span></div>
    <div class="nav-links">
      <a href="#">Start</a><a href="#">Programme</a><a href="#">Über uns</a><a href="#">Kontakt</a>
    </div>
  </nav>
  <section class="hero">
    <div class="hero-text">
      <h1>MutWerk —<br><em>Demokratie beginnt mit Dir</em></h1>
      <p>Junge Menschen stärken mit praxisnahen Bildungsprogrammen für Schulen.</p>
      <a href="#" class="btn">Unsere Angebote</a>
    </div>
    <div class="hero-img">[ Hero Illustration ]</div>
  </section>
  <section class="programs">
    <h2>Unsere Programme</h2>
    <div class="grid">
      <div class="card"><h3>Demokratie-Werkstatt</h3><p>Interaktive Workshops direkt in der Schule.</p></div>
      <div class="card"><h3>Jugend & Teilhabe</h3><p>Projekte die junge Stimmen sichtbar machen.</p></div>
      <div class="card"><h3>Trainer:innen-Ausbildung</h3><p>Wir multiplizieren Wissen durch Peer Education.</p></div>
    </div>
  </section>
  <section class="cta">
    <h2>Sei dabei!</h2>
    <p>Demokratie beginnt mit Dir. Mach mit — als Schüler:in, Lehrkraft oder Schule.</p>
    <a href="#" class="btn btn-dark">Kontakt aufnehmen</a>
  </section>
</body>
</html>
```

## Do's and Don'ts

**Do:**
- Always use `write_file` with full HTML/CSS — not fragments
- Use semantic HTML (`<section>`, `<nav>`, `<main>`, `<footer>`)
- Use Inter or system fonts — avoid custom font dependencies
- Include responsive meta tag: `<meta name="viewport" content="width=device-width, initial-scale=1.0">`
- Use CSS variables for colors when possible
- Test designs at mobile widths before finalizing

**Don't:**
- Don't use inline styles — use `<style>` blocks or CSS files
- Don't hardcode image URLs — use relative paths or placeholders
- Don't use JavaScript frameworks — keep it plain HTML/CSS
- Don't use external CDN dependencies unless necessary
- Don't forget `confirm: true` when deleting projects
