---
name: typexperiments
description: Kinetic typography engine by Pablo Stanley for per-character text animations on HTML Canvas. Use when the user wants animated text effects (morph, explode, pour, wave, typewriter, vortex) on landing pages, hero sections, logos, headers, or any web UI. Also use when the user mentions "typexperiments," "kinetic typography," "text animation engine," "per-character animation," "Pablo Stanley text animation," "animated type on canvas," "Pretext text layout," or "text morphing canvas animation."
metadata:
  version: 1.0.0
  repository: https://github.com/pablostanley/typexperiments
  live: https://typexperiments.vercel.app
---

# Typexperiments — Kinetic Typography Engine

Kinetic typography engine powered by [Pretext](https://github.com/chenglou/pretext) — a fast, accurate text measurement library in pure TypeScript that bypasses DOM reflow entirely. Since Pretext computes exact line breaks and character widths at any container size without touching the DOM, you can lay out text at two different widths simultaneously, map every character between them, and animate the transition per-glyph on Canvas.

## Architecture

```
src/
  types.ts           — GlyphPosition, AnimatedGlyph, EffectName, EffectParams types
  easing.ts          — 5 easing functions: linear, easeInOutCubic, easeInOutQuad, easeOutElastic, easeOutBounce
  effects.ts         — 6 effects: morph, explode, pour, wave, typewriter, vortex
  layout-mapper.ts   — computeGlyphPositions() + getLayoutInfo() via Pretext + Canvas measureText
  animator.ts        — Animator class: orchestrates RAF loop, interpolates glyphs, drives effects
  renderer.ts        — Renderer class: Canvas 2D drawing, DPR-aware resize, per-glyph transforms
  lava.ts            — LavaExperiment: cursor-repulsion physics on text glyphs (bonus experiment)
  main.ts            — Demo app entry: view switching, control panel, slider bindings
```

## Available Effects

| Effect | Description | Continuous? |
|--------|-------------|-------------|
| `morph` | Smooth interpolation between two layout widths. Characters slide as line breaks shift. | No |
| `explode` | Characters scatter outward with rotation + fade, then reassemble. | No |
| `pour` | Text cascades into position line-by-line with elastic easing. | No |
| `wave` | Continuous sine-wave displacement across all characters. | Yes |
| `typewriter` | Characters appear one by one with a reveal animation. | No |
| `vortex` | Characters spiral inward from center into final positions. | No |

## Core Types

```typescript
type GlyphPosition = {
  char: string
  globalIndex: number
  x: number
  y: number
  width: number
  lineIndex: number
  segmentIndex: number
}

type AnimatedGlyph = {
  char: string
  x: number
  y: number
  width: number
  opacity: number
  scale: number
  rotation: number
}

type EffectParams = {
  duration: number        // ms
  stagger: number         // 0-100
  easing: EasingName
  scatterRadius: number   // explode only
  rotationIntensity: number // explode only
  waveAmplitude: number   // wave only
  waveFrequency: number   // wave only
  waveSpeed: number       // wave only
}
```

## How It Works

1. **Prepare** — `prepareWithSegments(text, font)` analyzes and measures text once via Canvas (no DOM reflow).
2. **Layout** — `layoutWithLines(prepared, width, lineHeight)` computes line breaks at any width in ~0.09ms.
3. **Map** — Walk each line's text to compute per-character (x, y) positions using cumulative `measureText`.
4. **Animate** — Interpolate between two sets of positions on a `requestAnimationFrame` loop.
5. **Render** — Draw each glyph to Canvas 2D with per-character transforms (position, opacity, scale, rotation).

## Installation

```bash
npm install @chenglou/pretext
npm install vite typescript --save-dev  # if starting fresh
```

## Usage

### Minimal setup

```typescript
import { prepareWithSegments } from '@chenglou/pretext'
import { computeGlyphPositions } from './layout-mapper'
import { Renderer } from './renderer'
import { Animator } from './animator'

const canvas = document.getElementById('myCanvas') as HTMLCanvasElement
const renderer = new Renderer(canvas)
const animator = new Animator(renderer)

const text = 'Hello world'
const font = '600 48px Inter, sans-serif'
const prepared = prepareWithSegments(text, font)

const lineHeight = 72
const width = 600
const fromPositions = computeGlyphPositions(prepared, width, lineHeight, 0, 0, font)
const toPositions = computeGlyphPositions(prepared, 300, lineHeight, 0, 0, font)

animator.setFont(font)
animator.setColor('#f0f0f0')
animator.setEffect('morph')
animator.params.duration = 1200
animator.params.stagger = 30
animator.setGlyphs(fromPositions, toPositions)
animator.play()
```

### Centering text on canvas

```typescript
import { getLayoutInfo } from './layout-mapper'

const info = getLayoutInfo(prepared, width, lineHeight)
const offsetX = (renderer.width - width) / 2
const offsetY = (renderer.height - info.height) / 2

const positions = computeGlyphPositions(prepared, width, lineHeight, offsetX, offsetY, font)
```

### Using different effects

```typescript
animator.setEffect('explode')
animator.params.scatterRadius = 400
animator.params.rotationIntensity = 3

animator.setEffect('wave')
animator.params.waveAmplitude = 20
animator.params.waveFrequency = 3
animator.params.waveSpeed = 2

animator.setEffect('pour')
animator.params.easing = 'easeOutElastic'

animator.setEffect('vortex')
animator.params.duration = 2000
animator.params.stagger = 20
```

### Static render (no animation)

```typescript
animator.setGlyphs(toPositions, toPositions)
animator.renderStatic()
```

### Morph between two widths (toggle)

```typescript
const narrow = Math.max(100, Math.round(width * 0.45))
animator.setGlyphs(
  computeGlyphPositions(prepared, width, lineHeight, offsetX, offsetY, font),
  computeGlyphPositions(prepared, narrow, lineHeight, offsetX, offsetY, font),
)
animator.setEffect('morph')
animator.play()
```

## Integration Patterns for Web Design

### Canvas fills a container

Style the canvas with CSS to fill its parent, then handle DPR in `Renderer.resize()`:

```css
canvas {
  width: 100%;
  height: 100%;
  display: block;
}
```

On window resize, call `renderer.resize()` and recompute positions.

### Using as a hero section background

Position the canvas behind your content with `position: absolute` / `z-index: -1`, render animated text as a decorative element.

### Animating on scroll/intersection

```typescript
const observer = new IntersectionObserver((entries) => {
  if (entries[0].isIntersecting) {
    animator.play()
  }
})
observer.observe(element)
```

### Color and font customization

```typescript
animator.setColor('#ff6b2b')     // any CSS color string
animator.setFont('700 64px "Playfair Display", serif')
```

## Lava Experiment (Bonus)

The `LavaExperiment` class creates interactive text where characters are pushed away from the cursor and spring back — like magnetic repulsion. Useful for playful hero sections or interactive typography.

```typescript
import { LavaExperiment } from './lava'

const lava = new LavaExperiment(canvas)
lava.setText('Your text here')
lava.setLayout('two-col')  // 'two-col' | 'three-col' | 'asymmetric' | 'single'
lava.params.radius = 140
lava.params.force = 150
lava.params.spring = 20
lava.params.damping = 0.75
lava.params.heatEnabled = false  // color characters near cursor
lava.params.rotateEnabled = true // rotate characters based on displacement
lava.start()
// lava.stop() to pause
```

## Debugging / Gotchas

- **Font loading**: Wait for `document.fonts.ready` before preparing text, especially with web fonts.
- **Canvas resize**: Always call `renderer.resize()` on window resize and recompute positions.
- **DPR**: `Renderer` handles device pixel ratio automatically — no extra work needed.
- **Whitespace**: `computeGlyphPositions` skips whitespace characters (spaces, tabs) to avoid empty glyphs.
- **Morph fade-in/out**: When the two layouts have different character counts, new characters fade in and removed characters fade out automatically.
- **Continuous effects**: `wave` runs indefinitely via RAF — call `animator.stop()` to pause.
