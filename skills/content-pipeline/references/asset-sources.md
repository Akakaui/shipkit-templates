# Asset Sources

## Icons (skip Lucide/Feather/Heroicons)

| Source | Type | URL | Usage |
|--------|------|-----|-------|
| Hugeicons Pro | 40K+ icons | hugeicons.com | `npm i @hugeicons/core-free-icons` or SVG CDN |
| Phosphor | 6 weights | phosphoricons.com | `npm i @phosphor-icons/web` or SVG download |
| Tabler | 5500+ MIT | tabler-icons.io | `npm i @tabler/icons` or SVG |

## Flat Illustrations

| Source | Type | URL | License |
|--------|------|-----|---------|
| unDraw | SVG illustrations | undraw.co | MIT - recolor, no account needed |
| manypixels | 4000+ flat | manypixels.co | CC0 / paid |
| Storyset | Animated flat | storyset.com | customize + download |

## Character Illustrations

| Source | Type | URL | License |
|--------|------|-----|---------|
| Humaaans | Mix-and-match | humaaans.com | CC0 |
| Open Peeps | Hand-drawn | openpeeps.com | CC0 |
| Ira Design | Gradient | iradesign.io | customizable |

## Stock Photos / Videos

| Source | Type | URL | License |
|--------|------|-----|---------|
| Unsplash | Photos | unsplash.com | Free |
| Pexels | Photos + Video | pexels.com | Free |
| Pixabay | Photos + Video + Audio | pixabay.com | Free |

## 3D / GLB

| Source | Type | URL | License |
|--------|------|-----|---------|
| Sketchfab | 3D models | sketchfab.com | Various (check per model) |
| Polyhaven | HDRIs + 3D | polyhaven.com | CC0 |
| Google Poly | 3D (archived) | poly.google.com | CC0 (legacy) |

## Audio / Sound Effects

| Source | Type | URL | License |
|--------|------|-----|---------|
| Pixabay Music | Royalty-free | pixabay.com/music | Free |
| Freesound | SFX | freesound.org | Various (CC) |
| ElevenLabs | AI voice | elevenlabs.io | API key needed |

## Brand Logos (fetch via browser)

```bash
# Fetch a brand logo from SimpleIcons (open-source brand SVGs)
curl -s "https://simpleicons.org/icons/<slug>.svg" -o "logo-<brand>.svg"

# Or via agent-browser screenshot
agent-browser open "https://simpleicons.org/?q=<brand>"
# Screenshot or locate the SVG element
```

## Fetch Pattern (via agent-browser)

```bash
# 1. Open the source page
agent-browser open "<source-url>"

# 2. Take snapshot to find the asset
agent-browser snapshot -i

# 3. Download or screenshot the asset
# For direct download URLs, use curl
curl -s "<direct-download-url>" -o "assets/<filename>"

# For SVG elements on a page, get the SVG HTML
agent-browser get html "<selector>"
```
