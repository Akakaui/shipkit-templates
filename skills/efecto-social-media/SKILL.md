---
name: efecto-social-media
description: Design social media assets with Efecto — Instagram posts, carousels, stories, YouTube thumbnails, TikTok covers, Twitter/X images, LinkedIn slides, Pinterest pins, and Facebook graphics. Use when asked to "design a post", "create a carousel", "make a thumbnail", "design social media", or any social content task. Requires Efecto MCP server.
metadata:
  mcp-server: efecto
  author: pablostanley
  version: "1.0.0"
  parent-skill: efecto-plugin
---

# Efecto — Social Media Design Guide

Design social media assets — Instagram, YouTube, TikTok, Twitter/X, LinkedIn, Pinterest, Facebook — using the Efecto design tool. Proper sizing, bold typography, and platform-specific best practices.

## Setup

Requires the Efecto MCP server. Install if not available:

```json
{
  "mcpServers": {
    "efecto": {
      "command": "npx",
      "args": ["-y", "@efectoapp/mcp"]
    }
  }
}
```

## How It Works

1. Call `create_session` to get a `designUrl`
2. User opens the URL in their browser
3. Push design commands via MCP tools — every change renders live
4. Iterate with natural language

## Session Workflow

```
create_session  label: "Instagram Carousel"
```

Returns `{ sessionId, documentId, designUrl }`. Call `wait_for_connection` (blocks until paired). To reconnect to an existing session, use `attach_session` with the existing URL.

### Building Social Media Designs

```
# 1. Create artboard (Instagram post)
create_artboard  name: "Slide 1"  width: 1080  height: 1080  backgroundColor: "#111827"  className: "flex flex-col"

# 2. Add content with JSX
add_section  parentId: "<artboard-id>"  jsx: '<section className="flex flex-col items-center justify-center gap-8 p-16 w-full h-full">
  <h1 className="text-7xl font-extrabold text-white text-center leading-none">Stop designing like it&apos;s 2020</h1>
  <p className="text-xl text-gray-400 font-medium">Swipe for 5 rules -></p>
</section>'

# 3. Duplicate for carousel slides
duplicate_artboard  artboardId: "<artboard-id>"  newName: "Slide 2"

# 4. Batch update the duplicate
get_document
batch_update  updates: [
  { nodeId: "abc", textContent: "01" },
  { nodeId: "def", textContent: "White space is not wasted space" }
]
```

### Critical Gotchas

- Artboard `className` must include `flex flex-col` — children overlap otherwise
- `backgroundColor` is a property, NOT a className — use `backgroundColor: "#111827"`
- Never use arbitrary hex in className — `bg-[#f9f9f9]` silently fails. Use named colors or inline `style`
- Use `grow` instead of `flex-1` — `flex-1` doesn't work in Efecto
- Buttons ignore children — use a flex container with `<span>` + `<svg>` instead
- Always add `w-full` on direct children of artboards
- For carousels: use `duplicate_artboard` then `batch_update`

### JSX Format

Write standard HTML tags with Tailwind `className`:

```
<div>/<section>/<nav>  → frame       <img>     → image
<h1>-<h6>/<p>/<span>   → text        <button>  → button
<a>                    → link        <svg>     → icon
```

Icons: `<svg icon="arrow-right" className="w-5 h-5" />`

## Images — Use Real Photos

Use `search_images` to find free stock photos from Lummi. No session required.

```
search_images
  query: "team celebration"
  orientation: "square"
  luminance: "bright"
  limit: 4
```

Apply images: `set_fill` with `{ type: "image", url: "<url>", size: "cover" }` or `<img>` in JSX.

## Shader Nodes & Visual Effects

Add shader nodes for generative backgrounds and image effects:

```
add_node
  parentId: "<artboard-id>"
  type: "shader"
  shaderType: "meshGradient"
  className: "w-full h-full"
```

**Shader types**: `meshGradient`, `liquidMetal`, `chrome`, `pulsar`, `particles`, `fireworks`

**Image effects**: `ascii-standard`, `dither-atkinson`, `halftone-mono`, `glitch-vhs`, `glitch-digital`, `art-kuwahara`

**Post-processes**: `grain`, `vignette`, `scanlines`, `bloom`, `noise`, `pixelate`

## Native Animation

Use `list_animation_presets` then `apply_animation_plan`. Do NOT use Tailwind `animate-*` or `transition-*`.

Good defaults: 0.35-0.6s for hero/headline, 0.18-0.35s for details, 0.04-0.1s stagger.

## Mindset: Think Poster, Not Website

- Type big — canvas is 1080px but renders at ~375px on phone
- Write less — max 2-3 short lines per slide
- Think like a billboard

## Typography for Social Media

| Role | Size | Weight |
|------|------|--------|
| Hero / Impact | `text-7xl` to `text-8xl` | `font-extrabold` or `font-black` |
| Slide headline | `text-4xl` to `text-5xl` | `font-bold` or `font-extrabold` |
| Supporting text | `text-2xl` to `text-3xl` | `font-medium` or `font-normal` |
| Labels / tags | `text-lg` to `text-xl` | `font-semibold` |
| Smallest allowed | `text-lg` | any |

## Copywriting Rules

- Max 6-8 words per headline
- One idea per slide
- Kill filler words (no "that", "just", "really", "very")
- Use sentence fragments
- Active voice, present tense
- No paragraphs
- CTAs are 2-3 words

## Platform Specifics

### Instagram

| Format | Width | Height |
|--------|-------|--------|
| Post (Square) | 1080 | 1080 |
| Portrait Post | 1080 | 1350 |
| Story / Reel | 1080 | 1920 |
| Carousel Slide | 1080 | 1080 |

**Carousel**: Slide 1 = hook, consistent design, one point per slide, numbered, last = CTA, swipe cue.

```jsx
// Hook slide
<section className="flex flex-col items-center justify-center gap-8 p-16 bg-gray-900 w-full h-full">
  <h1 className="text-7xl font-extrabold text-white text-center leading-none tracking-tight">Stop designing like it's 2020</h1>
  <p className="text-xl text-gray-400 font-medium">Swipe for 5 rules -></p>
</section>

// Content slide
<section className="flex flex-col justify-center gap-8 p-16 bg-gray-900 w-full h-full">
  <span className="text-8xl font-black text-blue-400">01</span>
  <h2 className="text-4xl font-bold text-white leading-snug">White space is not wasted space</h2>
  <p className="text-2xl text-gray-400 leading-relaxed">Let your design breathe.</p>
</section>

// CTA slide
<section className="flex flex-col items-center justify-center gap-6 p-16 bg-gray-900 w-full h-full">
  <h2 className="text-5xl font-extrabold text-white text-center">Found this useful?</h2>
  <p className="text-3xl text-blue-400 font-bold text-center">Save it. Share it.</p>
</section>
```

### YouTube

| Format | Width | Height |
|--------|-------|--------|
| Thumbnail | 1280 | 720 |
| Channel Banner | 2560 | 1440 |

**Thumbnail tips**: Face + emotion wins, max 3-5 words, massive text (`text-6xl` to `text-8xl`), high contrast, split composition, 2-3 colors max.

```jsx
<section className="flex items-center gap-8 p-12 bg-blue-600 w-full h-full">
  <div className="flex flex-col gap-4 grow">
    <h1 className="text-7xl font-black text-white leading-none uppercase">Stop doing this</h1>
    <p className="text-3xl font-bold text-blue-200">5 design mistakes</p>
  </div>
  <div className="w-[400px] h-[400px] bg-blue-800 rounded-3xl"></div>
</section>
```

### TikTok

| Format | Width | Height |
|--------|-------|--------|
| Video Cover | 1080 | 1920 |

Vertical 9:16, safe zone center 65%, `text-5xl` to `text-7xl` headlines.

### Pinterest

| Format | Width | Height |
|--------|-------|--------|
| Standard Pin | 1000 | 1500 |
| Long Pin | 1000 | 2100 |

Tall pins (2:3) win, text in top 60%, warm bright colors.

### Facebook

| Format | Width | Height |
|--------|-------|--------|
| Post Image | 1200 | 630 |
| Cover Photo | 1640 | 856 |
| Story | 1080 | 1920 |

Aggressive compression — use solid colors. Safe zone center 820x312 for cover.

### Twitter / X

| Format | Width | Height |
|--------|-------|--------|
| Image post | 1200 | 675 |
| Banner | 1500 | 500 |
| Thread graphic | 1200 | 675 |

High contrast, bold color blocks. `text-5xl` to `text-7xl` headlines.

### LinkedIn

| Format | Width | Height |
|--------|-------|--------|
| Post | 1200 | 1200 |
| Carousel slide | 1080 | 1080 |
| Banner | 1584 | 396 |

Professional-bold, include name/logo on every slide, numbered insights.

## General Design Rules

- Center-align most content
- Generous padding: `p-12` to `p-16`
- Vertically center: `justify-center`
- `w-full h-full` on top-level sections
- Minimum 4.5:1 contrast ratio
- Same background color across all slides
- Same headline position across slides
- Brand element in same spot on every slide
