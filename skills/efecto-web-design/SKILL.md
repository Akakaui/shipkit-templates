---
name: efecto-web-design
description: Design web pages and app UIs with Efecto — create sessions, build layouts with JSX and Tailwind CSS, manage artboards, and push real-time design changes via MCP tools. Use when asked to "design a page", "build a landing page", "create a website", "design a dashboard", "make a UI", or any visual design task. Requires Efecto MCP server.
metadata:
  mcp-server: efecto
  author: pablostanley
  version: "1.0.0"
  parent-skill: efecto-plugin
---

# Efecto — Design Web Pages with AI

Efecto is a real-time web design tool that AI agents control programmatically. You create a **session**, the user opens a URL in their browser, and you push design commands that render instantly. Every node maps to a real HTML element styled with Tailwind CSS — web-native, semantic, and pixel-accurate.

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

## How Sessions Work

```
Agent ──POST /execute──> Server ──SSE──> Browser (renders live)
```

## Design Principles

### Typography

Use a type scale. Pick 2 fonts max — one for headings (display/serif), one for body (sans).

**Recommended type scale:**
- Display: `text-6xl` (60px) or `text-7xl` (72px)
- H1: `text-5xl` (48px)
- H2: `text-4xl` (36px)
- H3: `text-3xl` (30px)
- H4: `text-2xl` (24px)
- Body: `text-base` (16px) or `text-lg` (18px)
- Small: `text-sm` (14px)

**Leading (line-height):**
- Tight headings: `leading-tight` or `leading-snug`
- Body text: `leading-relaxed` or `leading-7`/`leading-8`

**Tracking (letter-spacing):**
- Tight: `tracking-tight` for headings
- Wide: `tracking-wide` or `tracking-wider` for uppercase/all-caps labels

**Font weight:**
- Display/headings: `font-bold` (700) or `font-extrabold` (800)
- Subheadings: `font-semibold` (600)
- Body: `font-normal` (400) or `font-medium` (500)

### Layout

**Page sections stack vertically:**
- Each section is `w-full` with `px-4`, `px-6`, or `px-8` (responsive)
- Max content width: `max-w-6xl mx-auto` (72rem / 1152px)
- Narrow content: `max-w-3xl mx-auto` (48rem / 768px) for reading-focused pages
- Wide content: `max-w-7xl mx-auto` (80rem / 1280px) for dashboard/data pages

**Vertical rhythm:**
- Section spacing: `py-16 md:py-20` or `py-20 md:py-24`
- Between major sections: `py-24 md:py-32`

**Grid patterns:**
- 3-column feature grid: `grid grid-cols-1 md:grid-cols-3 gap-8`
- 2-column split: `grid grid-cols-1 lg:grid-cols-2 gap-12`
- 4-column: `grid grid-cols-2 lg:grid-cols-4 gap-6`

### Color

**Dark background (dark pages):**
- Background: `bg-black` or dark gray (`bg-neutral-900`, `bg-neutral-950`)
- Surface cards: `bg-neutral-800`, `bg-white/5`, `bg-neutral-900` with `border border-white/10`
- Primary text: `text-white`, `text-neutral-50`
- Secondary text: `text-neutral-400`, `text-neutral-500`
- Accent: any brand color — `text-blue-400`, `text-emerald-400`, etc.

**Light background (light pages):**
- Background: `bg-white`, `bg-neutral-50`, or `bg-stone-50`
- Surface cards: `bg-white` with subtle shadow (`shadow-sm`, `shadow-md`)
- Primary text: `text-neutral-900`, `text-gray-900`
- Secondary text: `text-neutral-500`, `text-gray-500`
- Accent: brand color — `text-blue-600`, `text-emerald-600`, etc.

**Gradient treatment for hero sections:**
- `bg-gradient-to-b from-neutral-900 to-black`
- `bg-gradient-to-br from-indigo-500 via-purple-500 to-pink-500`
- `bg-gradient-to-r from-blue-400 to-emerald-400` (text gradient with `bg-clip-text text-transparent`)

**Border treatment:**
- Subtle borders: `border border-white/10`, `border border-black/5`

### Spacing

Padding shortcuts:
- Section padding: `px-4 sm:px-6 lg:px-8`
- Card padding: `p-6`, `p-8`, `p-10`
- Element gap in flex/grid: `gap-4`, `gap-6`, `gap-8`, `gap-12`

### Shadows

**Cards and UI elements on dark:**
- Subtle: `shadow-lg` with dark background
- Raised: `shadow-xl` or `shadow-2xl`
- Glow: class doesn't exist natively — add a thick semi-transparent border instead: `border border-white/10`

**Cards on light:**
- Subtle: `shadow-sm`
- Medium: `shadow-md`
- Raised: `shadow-xl`

### Borders & Dividers

- Full-width divider: `border-t border-white/10` or `border-t border-neutral-200`
- Inline divider: `border-r border-white/10` or `border-r border-neutral-200`
- Rounded corners: `rounded-lg` (8px), `rounded-xl` (12px), `rounded-2xl` (16px)

### Responsive

- Mobile-first. Start with single-column, add breakpoints
- `sm:` (640px), `md:` (768px), `lg:` (1024px), `xl:` (1280px)
- `hidden md:block` to show on desktop only
- `flex flex-col md:flex-row` for side-by-side on desktop
- Fine-tune with `max-w-*` utilities in each breakpoint

### Visual Hierarchy

1. **Hero** — largest heading, subtext, primary CTA. Dark background with gradient overlay
2. **Social proof** — logo cloud or testimonial
3. **Features/benefits** — 3-column grid with icons + short descriptions
4. **How it works** — numbered steps or timeline
5. **Pricing** — 3 tiers, highlight featured plan with accent border
6. **FAQ** — accordion or stacked Q&A
7. **CTA** — final call to action with strong contrast
8. **Footer** — minimal, links + copyright

## Workflow

### Create the session

First, call `create_session`. Wait for the user to open the URL before proceeding. Call `wait_for_connection` to ensure the browser is connected.

### Create an artboard

Use `create_artboard` to create an artboard. Always pass a meaningful `name` and use `className: "flex flex-col"`. Sizes:
- Desktop hero: `{ width: 1440, height: 800 }`
- Full desktop page: `{ width: 1440, height: 3200 }` (scrollable)
- Dashboard: `{ width: 1440, height: 900 }`

### Add sections

Use `add_section` with JSX + Tailwind to build each section. Example:

```
add_section(artboardId, {
  className: "w-full px-6 lg:px-8 py-20 bg-black",
  children: `
    <div class="max-w-6xl mx-auto">
      <h2 class="text-4xl md:text-5xl font-bold text-white mb-4">Features</h2>
      <p class="text-lg text-neutral-400 max-w-2xl mb-12">Built for teams that ship.</p>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <div class="p-6 rounded-xl bg-neutral-900 border border-white/10">
          <h3 class="text-xl font-semibold text-white mb-2">Fast</h3>
          <p class="text-neutral-400">Lightning quick performance.</p>
        </div>
      </div>
    </div>
  `
})
```

### Iterate

- Use `get_document` to inspect the current state and get node IDs
- Use `batch_update` to update multiple nodes at once
- Use `replace_section` to swap out an entire section

### Add polish

- Use `set_theme` to define a color palette
- Use `audit_design` to check for spacing, contrast, or layout issues
- Use `repair_design` to fix flagged issues

### Add animations

After the layout is locked, use `list_animation_presets` to see available options, then `apply_animation_plan` to add motion.

### Export

Use `export_image` to export any artboard as PNG, JPG, SVG, or PDF.

## Design Examples

### Hero Section (Dark)

```jsx
<div class="w-full px-6 lg:px-8 py-24 md:py-32 bg-gradient-to-b from-neutral-900 to-black">
  <div class="max-w-6xl mx-auto text-center">
    <h1 class="text-5xl md:text-7xl font-bold tracking-tight text-white mb-6">
      Build faster.<br/>Ship sooner.
    </h1>
    <p class="text-lg md:text-xl text-neutral-400 max-w-2xl mx-auto mb-10">
      The platform that helps teams move from idea to production in record time.
    </p>
    <div class="flex flex-col sm:flex-row gap-4 justify-center">
      <button class="px-8 py-3 bg-white text-black font-semibold rounded-lg hover:bg-neutral-200">
        Get started
      </button>
      <button class="px-8 py-3 border border-white/20 text-white font-semibold rounded-lg hover:bg-white/5">
        Talk to sales
      </button>
    </div>
  </div>
</div>
```

### Logo Cloud

```jsx
<div class="w-full px-6 lg:px-8 py-16 bg-black">
  <div class="max-w-6xl mx-auto text-center">
    <p class="text-sm font-medium text-neutral-500 tracking-wide uppercase mb-8">
      Trusted by teams worldwide
    </p>
    <div class="flex flex-wrap justify-center gap-x-12 gap-y-6">
      <div class="text-neutral-600 text-2xl font-bold">Company A</div>
      <div class="text-neutral-600 text-2xl font-bold">Company B</div>
      <div class="text-neutral-600 text-2xl font-bold">Company C</div>
      <div class="text-neutral-600 text-2xl font-bold">Company D</div>
      <div class="text-neutral-600 text-2xl font-bold">Company E</div>
    </div>
  </div>
</div>
```

### Feature Grid

```jsx
<div class="w-full px-6 lg:px-8 py-20 bg-neutral-900">
  <div class="max-w-6xl mx-auto">
    <h2 class="text-4xl md:text-5xl font-bold text-white mb-4">Everything you need</h2>
    <p class="text-lg text-neutral-400 max-w-2xl mb-16">Powerful features for modern teams.</p>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <div class="p-8 rounded-2xl bg-black border border-white/5">
        <div class="w-10 h-10 rounded-lg bg-blue-500/20 flex items-center justify-center mb-4">
          <span class="text-blue-400 text-lg">Z</span>
        </div>
        <h3 class="text-xl font-semibold text-white mb-2">Real-time sync</h3>
        <p class="text-neutral-400 leading-relaxed">Changes propagate instantly across all clients.</p>
      </div>
      <div class="p-8 rounded-2xl bg-black border border-white/5">
        <div class="w-10 h-10 rounded-lg bg-emerald-500/20 flex items-center justify-center mb-4">
          <span class="text-emerald-400 text-lg">Z</span>
        </div>
        <h3 class="text-xl font-semibold text-white mb-2">Zero config</h3>
        <p class="text-neutral-400 leading-relaxed">Start in seconds with sensible defaults.</p>
      </div>
      <div class="p-8 rounded-2xl bg-black border border-white/5">
        <div class="w-10 h-10 rounded-lg bg-purple-500/20 flex items-center justify-center mb-4">
          <span class="text-purple-400 text-lg">Z</span>
        </div>
        <h3 class="text-xl font-semibold text-white mb-2">API-first</h3>
        <p class="text-neutral-400 leading-relaxed">Integrate with your existing toolchain.</p>
      </div>
    </div>
  </div>
</div>
```

### Pricing Section

```jsx
<div class="w-full px-6 lg:px-8 py-20 bg-black">
  <div class="max-w-6xl mx-auto">
    <h2 class="text-4xl md:text-5xl font-bold text-white text-center mb-4">Simple pricing</h2>
    <p class="text-lg text-neutral-400 text-center max-w-xl mx-auto mb-16">
      No hidden fees. No surprises.
    </p>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-5xl mx-auto">
      <div class="p-8 rounded-2xl bg-neutral-900 border border-white/10">
        <h3 class="text-lg font-semibold text-white mb-2">Starter</h3>
        <p class="text-4xl font-bold text-white mb-1">$19</p>
        <p class="text-sm text-neutral-500 mb-8">per month</p>
        <ul class="space-y-3 mb-10">
          <li class="flex items-center gap-3 text-neutral-300"><span class="text-emerald-400">Z</span>5 projects</li>
          <li class="flex items-center gap-3 text-neutral-300"><span class="text-emerald-400">Z</span>10GB storage</li>
          <li class="flex items-center gap-3 text-neutral-300"><span class="text-emerald-400">Z</span>Basic support</li>
        </ul>
        <button class="w-full py-3 rounded-lg border border-white/20 text-white font-semibold hover:bg-white/5">Get started</button>
      </div>
      <div class="p-8 rounded-2xl bg-white border-2 border-blue-500 relative">
        <div class="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-blue-500 text-white text-xs font-semibold rounded-full">Popular</div>
        <h3 class="text-lg font-semibold text-neutral-900 mb-2">Pro</h3>
        <p class="text-4xl font-bold text-neutral-900 mb-1">$49</p>
        <p class="text-sm text-neutral-500 mb-8">per month</p>
        <ul class="space-y-3 mb-10">
          <li class="flex items-center gap-3 text-neutral-700"><span class="text-emerald-500">Z</span>Unlimited projects</li>
          <li class="flex items-center gap-3 text-neutral-700"><span class="text-emerald-500">Z</span>100GB storage</li>
          <li class="flex items-center gap-3 text-neutral-700"><span class="text-emerald-500">Z</span>Priority support</li>
          <li class="flex items-center gap-3 text-neutral-700"><span class="text-emerald-500">Z</span>Custom domains</li>
        </ul>
        <button class="w-full py-3 rounded-lg bg-neutral-900 text-white font-semibold hover:bg-neutral-800">Get started</button>
      </div>
      <div class="p-8 rounded-2xl bg-neutral-900 border border-white/10">
        <h3 class="text-lg font-semibold text-white mb-2">Enterprise</h3>
        <p class="text-4xl font-bold text-white mb-1">$149</p>
        <p class="text-sm text-neutral-500 mb-8">per month</p>
        <ul class="space-y-3 mb-10">
          <li class="flex items-center gap-3 text-neutral-300"><span class="text-emerald-400">Z</span>Everything in Pro</li>
          <li class="flex items-center gap-3 text-neutral-300"><span class="text-emerald-400">Z</span>Unlimited storage</li>
          <li class="flex items-center gap-3 text-neutral-300"><span class="text-emerald-400">Z</span>Dedicated support</li>
          <li class="flex items-center gap-3 text-neutral-300"><span class="text-emerald-400">Z</span>SAML SSO</li>
        </ul>
        <button class="w-full py-3 rounded-lg border border-white/20 text-white font-semibold hover:bg-white/5">Contact us</button>
      </div>
    </div>
  </div>
</div>
```

### Dashboard Layout

```jsx
<div class="w-full h-full bg-neutral-950 flex">
  <!-- Sidebar -->
  <div class="w-64 h-full bg-neutral-900 border-r border-white/5 p-6 flex flex-col gap-6">
    <div class="text-white font-bold text-xl">Logo</div>
    <nav class="flex flex-col gap-2">
      <div class="px-3 py-2 rounded-lg bg-white/10 text-white font-medium">Dashboard</div>
      <div class="px-3 py-2 rounded-lg text-neutral-400 hover:text-white hover:bg-white/5">Analytics</div>
      <div class="px-3 py-2 rounded-lg text-neutral-400 hover:text-white hover:bg-white/5">Settings</div>
    </nav>
  </div>
  <!-- Main -->
  <div class="flex-1 p-8">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
      <div class="p-6 rounded-xl bg-neutral-900 border border-white/5">
        <p class="text-sm text-neutral-400 mb-1">Revenue</p>
        <p class="text-3xl font-bold text-white">$48,290</p>
      </div>
      <div class="p-6 rounded-xl bg-neutral-900 border border-white/5">
        <p class="text-sm text-neutral-400 mb-1">Users</p>
        <p class="text-3xl font-bold text-white">2,847</p>
      </div>
      <div class="p-6 rounded-xl bg-neutral-900 border border-white/5">
        <p class="text-sm text-neutral-400 mb-1">Active</p>
        <p class="text-3xl font-bold text-white">1,203</p>
      </div>
    </div>
  </div>
</div>
```

## Pattern Library

### Buttons
- Primary: `px-6 py-3 bg-white text-black font-semibold rounded-lg hover:bg-neutral-200`
- Secondary: `px-6 py-3 border border-white/20 text-white font-semibold rounded-lg hover:bg-white/5`
- Ghost: `px-6 py-3 text-neutral-400 font-medium hover:text-white`
- Large: `px-8 py-4 text-lg`
- Small: `px-4 py-2 text-sm`

### Cards
- Dark: `p-6 rounded-xl bg-neutral-900 border border-white/10`
- Dark elevated: `p-8 rounded-2xl bg-neutral-900 border border-white/10 shadow-xl`
- Light: `p-6 rounded-xl bg-white shadow-sm border border-neutral-100`

### Inputs
- Dark: `w-full px-4 py-3 rounded-lg bg-neutral-800 border border-white/10 text-white placeholder-neutral-500`
- Light: `w-full px-4 py-3 rounded-lg bg-white border border-neutral-200 text-neutral-900 placeholder-neutral-400`

### Navigation links
- Dark: `text-neutral-400 hover:text-white transition-colors`
- Active: `text-white font-medium`

### Badges / Tags
- `px-2.5 py-1 rounded-full text-xs font-medium bg-blue-500/20 text-blue-400`

### Avatars
- `w-10 h-10 rounded-full bg-neutral-700`
- With image: `w-10 h-10 rounded-full object-cover`

### Dividers
- `w-full border-t border-white/10 my-8`

## Do's and Don'ts

**Do:**
- Start each section with a clean `add_section` that covers `w-full` + horizontal padding
- Nest content inside `max-w-6xl mx-auto` rather than applying margins to children
- Use `gap-*` on flex/grid containers instead of margin on children
- Add `transition-colors` or `transition-all` to interactive elements
- Use `batch_update` when updating many nodes at once

**Don't:**
- Don't set explicit widths on inner elements that break at different artboard sizes — use the grid system
- Don't set `h-screen` or `min-h-screen` on artboard sections — artboards have natural height
- Don't use `fixed` or `sticky` positioning on artboard sections (they don't scroll within the artboard)
- Don't forget to wrap text content in elements with proper text color
