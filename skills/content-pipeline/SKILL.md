---
name: content-pipeline
description: Anti-slop web design + programmatic video creation. Never use generic AI-generated full-page slop. Use real assets (logos, icons, illustrations from real sources), compose in HTML/CSS, and create programmatic videos via Remotion + Higgsfield + ElevenLabs.
---

# Content Pipeline Skill

## Core Principles

1. **No AI slop.** Never generate a full-page AI image as a design. Always compose HTML/CSS with real assets.
2. **Real assets first.** Fetch logos, icons, illustrations from real sources before generating AI versions.
3. **Ask first.** If you can't find or generate an asset, ask the user — don't silently substitute.
4. **Structured pipeline.** Every project follows: brief/script -> plan -> source assets -> compose -> output.
5. **Design goes to Open Design.** Save design projects to Open Design workspace.
6. **Video goes to Remotion.** Compose programmatic videos with scenes, narration, and assets.

---

## Web Design Workflow

### Brief to Design

1. **Parse the brief** — understand the brand, target audience, tone, and deliverables
2. **Plan the layout** — sketch sections (hero, features, pricing, footer, etc.)
3. **Source real assets:**
   - **Logos:** Fetch from brand page via agent-browser or curl
   - **Icons:** Hugeicons Pro, Phosphor — reference via CDN or download SVG
   - **Illustrations:** unDraw, Humaaans, Open Peeps — download SVGs
   - **Photos:** Unsplash, Pexels for free stock
   - **AI images:** Higgsfield/Recraft/FLUX for custom images the user needs
4. **Compose HTML/CSS** — code a real layout with embedded real assets
5. **Preview** — via agent-browser or tell user to open the HTML file
6. **Refine** — iterate based on feedback

### Anti-Slop Rules

- NEVER generate a full-page AI image as a design mockup
- NEVER use Lucide, Feather, Heroicons, or React icon libraries
- ALWAYS use real asset files (SVG, PNG, WEBP) downloaded or fetched
- ALWAYS compose layouts in actual HTML/CSS code
- ALWAYS ask the user before substituting a lookalike asset

---

## Video Creation Workflow (Remotion)

### Script to Video

1. **Get the script** — user provides, I write, or we collaborate
2. **Break into scenes** — each scene gets: visuals + narration + timing
3. **Ask before rendering:**
   - Output format (16:9 YouTube, 9:16 reel/short, 1:1 Instagram, custom)
   - Voice-over choice (ElevenLabs voice id, or user uploads audio)
   - Duration per scene
4. **Per scene, source assets:**
   - **Backgrounds/videos:** Higgsfield generate, browser fetch, or user uploads
   - **Images:** Higgsfield generate, browser fetch from free libraries, or user uploads
   - **3D GLBs:** Sketchfab, Polyhaven, or user provides
   - **Icons:** Hugeicons/Phosphor
5. **Generate voice-over** — via ElevenLabs API with chosen voice
6. **Save all assets** to `./assets/scene-*/` folder
7. **Compose Remotion project:**
   - Each scene is a React component
   - Sequence them with transitions
   - Audio track per scene
8. **Render MP4** — `npx remotion render` or programmatic render
9. **Output** — deliver final video file

### Asset Sourcing Order (per scene)

1. **Fetch from web** — logos, stock photos, free illustrations via agent-browser
2. **Generate via Higgsfield** — images, video clips, backgrounds
3. **User upload** — ask before generating if unsure

---

## Tool Integration

| Tool | Purpose | Integration |
|------|---------|-------------|
| agent-browser | Fetch assets from web, preview designs | `agent-browser open ...` + screenshot or download |
| Hugeicons Pro | Icon library | `@hugeicons/core-free-icons` npm or SVG CDN |
| Phosphor | Alternative icon library | `@phosphor-icons/web` |
| unDraw | Flat illustrations | undraw.co - download SVG directly |
| Humaaans | Character illustrations | humaaans.com - download SVG |
| Open Peeps | Hand-drawn characters | openpeeps.com - download SVG |
| Higgsfield | Image + video generation | MCP or REST API |
| ElevenLabs | Voice-over narration | REST API with voice ID |
| Remotion | Programmatic video | `npx remotion` CLI |
| Three.js / @react-three/fiber | 3D GLB in video | npm package |

---

## Open Design Integration

- Design projects (landing pages, prototypes, UI) go through Open Design
- Skills are saved to `~/open-design/skills/content-pipeline/` for the design workspace
- The workflow is: design in Open Design -> extract HTML/CSS -> enhance with real assets -> deliver

---

## File Conventions

```
project-root/
├── assets/
│   ├── scene-01/
│   │   ├── background.mp4
│   │   ├── overlay.png
│   │   └── narration.mp3
│   ├── scene-02/
│   └── ...
├── src/
│   ├── Root.tsx
│   ├── scenes/
│   │   ├── Scene01.tsx
│   │   └── Scene02.tsx
│   └── composition.ts
├── remotion.config.ts
└── output.mp4
```
