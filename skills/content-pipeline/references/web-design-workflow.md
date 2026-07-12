# Web Design Workflow

## Principles

1. **Code real HTML/CSS.** Never generate a full-page AI image as a design deliverable.
2. **Use real assets.** Every logo, icon, and illustration must be from a real source or generated specifically for this project.
3. **No React icon libraries.** No Lucide, Feather, Heroicons. Use Hugeicons, Phosphor, or hand-crafted SVGs.
4. **Compose, don't hallucinate.** Every element in the layout should be deliberate.

## Workflow

### 1. Parse Brief
```yaml
brand: "Company Name"
tone: modern | playful | serious | luxury
sections: hero, features, pricing, footer
colors: from brand or ask
assets: logo needed, screenshots, etc.
```

### 2. Source Assets

**Logos:** Fetch via browser from brand site or SimpleIcons:
```bash
# SimpleIcons has SVG brand logos
curl -s "https://simpleicons.org/icons/<brand-slug>.svg" -o "assets/logo.svg"
```

**Icons:** Use Hugeicons or Phosphor via CDN:
```html
<!-- Hugeicons CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@hugeicons/core-free-icons/dist/hugeicons.css" />
```

**Illustrations:** Download SVG from unDraw, Humaaans, or Open Peeps via browser:
```bash
agent-browser open "https://undraw.co/illustrations"
# Find and download the right SVG
```

**AI Images:** Generate via Higgsfield when a specific image is needed that can't be sourced.

### 3. Compose HTML/CSS

- Write semantic HTML
- CSS grid/flexbox layout
- Embed assets as `<img>`, `<svg>`, or CSS backgrounds
- Use real fonts (Google Fonts or system)

### 4. Preview

```bash
# Open the HTML file in browser
agent-browser open "file://<path-to-html>"
# Take screenshot for review
agent-browser screenshot "preview.png"
```

### 5. Deliver

- Provide the HTML/CSS files
- Include asset folder
- List what assets are real vs AI-generated
- Note any assets the user needs to provide
