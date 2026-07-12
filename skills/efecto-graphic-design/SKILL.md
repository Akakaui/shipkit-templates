---
name: efecto-graphic-design
description: Design graphic assets with Efecto — presentations, pitch decks, event posters, email headers, blog images, open graph cards, business cards, resumes, menus, infographics, invitations, newsletters, and documents. Use when asked to "design a poster", "create a pitch deck", "make a presentation", "design a business card", or any graphic design task. Requires Efecto MCP server.
metadata:
  mcp-server: efecto
  author: pablostanley
  version: "1.0.0"
  parent-skill: efecto-plugin
---

# Efecto — Graphic Design Guide

Design graphic assets — presentations, pitch decks, event posters, email headers, blog images, OG cards, business cards, resumes, menus, infographics, invitations, newsletters, and documents — using the Efecto design tool.

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
2. User opens URL in browser
3. Push design commands via MCP — every change renders live
4. Iterate with natural language

## Workflow

```
create_session  label: "Pitch Deck"

create_artboard  name: "Slide 1"  width: 1920  height: 1080  backgroundColor: "#1a1a1a"  className: "flex flex-col"

add_section  parentId: "<id>"  jsx: '<section className="flex flex-col items-center justify-center gap-6 p-24 w-full h-full">
  <h1 className="text-7xl font-extrabold text-white text-center">Your Title</h1>
  <p className="text-2xl text-gray-400">Subtitle</p>
</section>'

get_document  # get node IDs

batch_update  updates: [
  { nodeId: "abc", className: "text-8xl font-black text-white" }
]
```

### Critical Gotchas

- Artboard `className` must include `flex flex-col`
- `backgroundColor` is a property, NOT a className
- Never use `bg-[#hex]` — use named colors or inline `style`
- Use `grow` instead of `flex-1`
- Buttons ignore children — use flex container with `<span>` + `<svg>` instead
- Always `w-full` on direct children of artboards

## Images

Use `search_images` to find free stock photos from Lummi. No session required.

```
search_images
  query: "conference stage audience"
  orientation: "horizontal"
  luminance: "dark"
  limit: 4
```

## Shader Nodes & Visual Effects

```
add_node
  parentId: "<id>"
  type: "shader"
  shaderType: "meshGradient"
  className: "w-full h-full"
```

**Shader types**: `meshGradient`, `dotGrid`, `voronoi`, `liquidMetal`, `chrome`, `pulsar`, `blackHole`, `glass`, `spiral`, `particles`, `fireworks`

**Image effects**: `ascii-standard`, `ascii-dense`, `ascii-blocks`, `dither-floyd-steinberg`, `dither-atkinson`, `halftone-mono`, `halftone-cmyk`, `glitch-vhs`, `glitch-digital`, `art-kuwahara`, `art-crosshatch`, `art-lineart`, `art-engraving`, `art-stipple`

**Post-processes**: `grain`, `vignette`, `bloom`, `scanlines`, `noise`, `pixelate`, `sepia`, `color-tint`

## Native Animation

Use `list_animation_presets` then `apply_animation_plan`. No Tailwind `animate-*`. Good defaults: 0.35-0.6s hero, 0.18-0.35s details, 0.04-0.12s stagger.

## Presentations & Pitch Decks

| Format | Width | Height |
|--------|-------|--------|
| Standard (16:9) | 1920 | 1080 |
| Widescreen (16:10) | 1920 | 1200 |
| Classic (4:3) | 1440 | 1080 |

### Rules
- One idea per slide
- Nothing smaller than `text-3xl` at 1920px
- 6 words per line, 6 lines max
- Full-bleed visuals with solid text overlay
- Subtle slide numbers

### Slide Templates

**Title slide:**
```jsx
<section className="flex flex-col items-center justify-center gap-6 p-24 bg-gray-900 w-full h-full">
  <span className="text-xl font-semibold text-blue-400 uppercase tracking-widest">Q4 2026 Update</span>
  <h1 className="text-7xl font-extrabold text-white text-center leading-none tracking-tight">Building the Future of Design</h1>
  <p className="text-2xl text-gray-400 font-medium">Acme Inc. / October 2026</p>
</section>
```

**Section divider:**
```jsx
<section className="flex flex-col items-start justify-center gap-4 px-24 py-16 bg-blue-600 w-full h-full">
  <span className="text-xl font-bold text-blue-200 uppercase tracking-widest">Part 02</span>
  <h2 className="text-6xl font-extrabold text-white leading-tight">Product Strategy</h2>
</section>
```

**Content slide:**
```jsx
<section className="flex items-center gap-16 px-24 py-16 bg-white w-full h-full">
  <div className="flex flex-col gap-6 grow">
    <h2 className="text-4xl font-bold text-gray-900 leading-snug">Revenue grew 3x in 12 months</h2>
    <p className="text-2xl text-gray-500 leading-relaxed">We hit $10M ARR ahead of schedule.</p>
  </div>
  <div className="w-[600px] h-[500px] bg-gray-100 rounded-3xl"></div>
</section>
```

**Big number slide:**
```jsx
<section className="flex flex-col items-center justify-center gap-6 p-24 bg-gray-900 w-full h-full">
  <span className="text-9xl font-black text-blue-400">3x</span>
  <h2 className="text-4xl font-bold text-white text-center">Revenue growth in 12 months</h2>
  <p className="text-xl text-gray-500">$3.2M to $10M ARR</p>
</section>
```

**Quote slide:**
```jsx
<section className="flex flex-col items-center justify-center gap-8 px-32 py-24 bg-gray-50 w-full h-full">
  <p className="text-4xl text-gray-700 text-center leading-relaxed italic">"The best tool we've adopted this year."</p>
  <div className="flex items-center gap-4">
    <div className="w-16 h-16 bg-gray-300 rounded-full"></div>
    <div className="flex flex-col">
      <span className="text-xl font-semibold text-gray-900">Jamie Rivera</span>
      <span className="text-lg text-gray-500">Head of Design, Linear</span>
    </div>
  </div>
</section>
```

**Closing slide:**
```jsx
<section className="flex flex-col items-center justify-center gap-8 p-24 bg-gray-900 w-full h-full">
  <h2 className="text-6xl font-extrabold text-white text-center">Let's build together</h2>
  <p className="text-2xl text-gray-400 text-center">hello@acme.com</p>
</section>
```

### Pitch Deck Flow (10 slides)
1. Title — company, tagline, date
2. Problem — one stat or quote
3. Solution — one sentence + visual
4. Demo — screenshot or mockup
5. Market — TAM/SAM/SOM
6. Traction — big numbers
7. Business Model — simple diagram
8. Team — photos + one-line bios
9. Ask — funding amount
10. Closing — contact info

### Speaker Notes
Every slide has `speakerNotes` — pass to `create_artboard` or `update_artboard`. Write the script, not the slide content. 2-4 sentences per slide.

```
create_artboard:
  name: "03 — Traction"
  width: 1920
  height: 1080
  backgroundColor: "#0a0a0a"
  className: "flex flex-col"
  speakerNotes: "Walk through 3x ARR growth. Highlight 80% from enterprise upgrades."
```

## Event Posters & Flyers

| Format | Width | Height |
|--------|-------|--------|
| Digital Poster | 1080 | 1350 |
| A4 Portrait | 794 | 1123 |
| Letter Portrait | 816 | 1056 |
| Wide Banner | 1920 | 600 |

**Hierarchy**: What > When > Where > CTA

```jsx
<section className="flex flex-col justify-between p-16 bg-gray-900 w-full h-full">
  <div className="flex items-center justify-between">
    <span className="text-lg font-bold text-gray-400 uppercase tracking-widest">Design Conf 2026</span>
    <div className="w-12 h-12 bg-blue-500 rounded-xl"></div>
  </div>
  <div className="flex flex-col gap-6">
    <h1 className="text-7xl font-black text-white leading-none">The Future of Interface Design</h1>
    <p className="text-3xl font-bold text-blue-400">March 15, 2026</p>
    <p className="text-2xl text-gray-400">San Francisco</p>
    <button className="w-fit px-10 py-4 text-xl font-bold text-gray-900 bg-white rounded-2xl">Get Tickets</button>
  </div>
</section>
```

## Email Headers & Newsletter Graphics

| Format | Width | Height |
|--------|-------|--------|
| Email Header | 600 | 200 |
| Email Hero | 600 | 400 |
| Wide Hero | 1200 | 400 |

600px max width. Simple layouts. Big CTA. Brand-heavy.

```jsx
<section className="flex items-center justify-between px-8 py-6 bg-gray-900 w-full h-full">
  <div className="flex items-center gap-3">
    <div className="w-8 h-8 bg-blue-500 rounded-lg"></div>
    <span className="text-xl font-bold text-white">Acme Weekly</span>
  </div>
  <span className="text-lg text-gray-400">March 2026</span>
</section>
```

## Blog & Article Hero Images

| Format | Width | Height |
|--------|-------|--------|
| Blog Hero (16:9) | 1200 | 675 |
| Medium Article | 1400 | 788 |
| Substack | 1456 | 816 |

Set the mood, not deliver info. Text optional.

```jsx
<section className="flex flex-col items-center justify-center gap-6 px-16 py-16 bg-gray-900 w-full h-full">
  <span className="text-lg font-semibold text-blue-400 uppercase tracking-widest">Engineering</span>
  <h1 className="text-5xl font-extrabold text-white text-center leading-tight max-w-[900px]">How we reduced build times by 80%</h1>
  <p className="text-xl text-gray-500 font-medium">March 2026 / 8 min read</p>
</section>
```

## OG Images & Share Cards

| Format | Width | Height |
|--------|-------|--------|
| Open Graph | 1200 | 630 |
| Twitter Card | 1200 | 628 |

Title is king (`text-5xl` to `text-6xl`). Brand anchor in corner. No fine details.

```jsx
<section className="flex items-center gap-12 px-16 py-12 bg-white w-full h-full">
  <div className="flex flex-col gap-4 grow">
    <div className="flex items-center gap-2">
      <div className="w-8 h-8 bg-blue-600 rounded-lg"></div>
      <span className="text-lg font-bold text-gray-400">acme.com</span>
    </div>
    <h1 className="text-5xl font-extrabold text-gray-900 leading-tight">How we reduced build times by 80%</h1>
    <p className="text-xl text-gray-500">A deep dive into our new CI/CD pipeline.</p>
  </div>
  <div className="w-[250px] h-[250px] bg-blue-100 rounded-3xl"></div>
</section>
```

## Business Cards

| Format | Width | Height |
|--------|-------|--------|
| Standard | 336 | 192 |
| Hi-fi | 672 | 384 |

Two artboards: Front + Back. 3-level hierarchy (name > title > contact). 2 colors max.

## Resumes / CVs

| Format | Width | Height |
|--------|-------|--------|
| US Letter | 816 | 1056 |
| A4 | 794 | 1123 |

ONE page. Scannable in 6 seconds. Two-column layout (sidebar + main). One accent color.

## Infographics

| Format | Width | Height |
|--------|-------|--------|
| Standard | 1080 | 2400-3200 |

One continuous artboard. Story first. One key insight. Top-to-bottom flow.

## General Tips

### Composition
- 3-second hierarchy test
- Rule of thirds
- Whitespace is structure
- One visual anchor

### Color
- 3-color rule (60-30-10 split)
- Test at 50% zoom

### Typography
- 2 fonts max
- Headline at least 2x body size
- `tracking-wide` on uppercase text

### Format Quick Reference

| Asset | Size | Key Rule |
|-------|------|----------|
| Presentation | 1920x1080 | One idea per slide, min `text-3xl` |
| Pitch Deck | 1920x1080 | 10 slides, big numbers, minimal text |
| Event Poster | 1080x1350 | What + When + Where + CTA |
| Email Header | 600x200 | Brand + one line, 600px max |
| Blog Hero | 1200x675 | Atmospheric, optional text |
| OG Image | 1200x630 | Title + brand, works at 300px |
| Business Card | 336x192 | 2 colors max, 3-level hierarchy |
| Resume | 816x1056 | ONE page, scannable in 6 seconds |
| Flyer | 816x1056 | Headline PUNCHES, WHAT+WHEN+WHERE+HOW |
| Menu | 816x1056 | Scannable categories, prices visible |
| Infographic | 1080x3200 | One key insight, top-to-bottom |
| Invitation | 672x480 | Emotion first, match formality |
| Newsletter | 640x1200 | Single column, max 640px |
| Document | 816x1056 | 5-level hierarchy, professional restraint |
