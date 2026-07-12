---
name: efecto-plugin
description: AI-native visual design tool by Pablo Stanley for real-time design via MCP. Use when the user wants to design websites, landing pages, dashboards, social media graphics, Instagram carousels, YouTube thumbnails, pitch decks, presentations, posters, business cards, logos, icons, illustrations, email headers, OG images, infographics, or any visual design asset. Also use when the user mentions "Efecto," "efecto-plugin," "Pablo Stanley design," "AI design tool," "design with AI," "real-time design canvas," "MCP design," "design in browser," "make a landing page," "create a logo," "design social media," or "visual design agent." Covers web design, social media design, and graphic design with 68 MCP tools for programmatic real-time design. Requires Efecto MCP server via `npx -y @efectoapp/mcp`.
metadata:
  author: pablostanley
  version: 1.0.0
  repository: https://github.com/pablostanley/efecto-plugin
  website: https://efecto.app
  docs: https://efecto.app/docs
  mcp-server: efecto
  sub-skills:
    - efecto-web-design
    - efecto-social-media
    - efecto-graphic-design
---

# Efecto — AI Design Skills + MCP Tools

Efecto is a real-time visual design tool that AI agents control programmatically via MCP (Model Context Protocol). Your AI agent creates a session, you open the URL in your browser, and the agent pushes live design commands — every change renders instantly. Web-native: every node is a real HTML element with Tailwind CSS.

Works with **Claude Code**, **Cursor**, **Windsurf**, **GitHub Copilot**, **Codex**, **Gemini CLI**, and any MCP-compatible agent.

## Quick Install

```bash
npx skills add pablostanley/efecto-plugin
```

This installs 3 design skills (below) + configures the Efecto MCP server.

### Manual MCP Setup

Add to your MCP config:

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

1. Agent calls `create_session` — gets a `designUrl` back
2. User opens the URL in their browser
3. Agent pushes design commands via MCP tools — every change streams to the browser in real time
4. Iterate with natural language until the design is perfect

## 68 MCP Tools

### Session Management
- `create_session` — Create a new design session, returns `designUrl`
- `attach_session` — Reattach to an existing session by URL
- `wait_for_connection` — Wait for the browser to connect to the session
- `session_status` — Check if the browser is connected
- `close_session` — End the session

### Reading / Inspection
- `get_document` — Get the full document tree with all nodes
- `get_selection` — Get currently selected node IDs
- `get_node_tree` — Get hierarchical node tree from a node
- `list_artboards` — List all artboards
- `find_nodes` — Search nodes by text, className, or tag

### Creating
- `create_artboard` — Create an artboard (use `className: "flex flex-col"`)
- `add_section` — Add a section with JSX + Tailwind children to an artboard
- `add_node` — Add a single node as a child of an existing node

### Modifying
- `update_node` — Update props, className, or innerText of a node
- `update_class` — Update the Tailwind className of a node
- `update_artboard` — Resize, rename, or recolor an artboard
- `batch_update` — Update multiple nodes at once (use for performance)
- `replace_section` — Replace a section entirely with new content

### Organizing
- `move_node` — Move a node to a new parent
- `duplicate_node` — Duplicate a node within its parent
- `duplicate_artboard` — Clone an entire artboard
- `group_nodes` — Wrap multiple nodes in a container div
- `ungroup_node` — Remove a group container, keeping children
- `reorder_node` — Change the order of a node within its parent

### Selection
- `select_nodes` — Select specific nodes by ID
- `deselect_all` — Deselect everything
- `set_visibility` — Show/hide a node
- `delete_nodes` — Remove nodes by ID
- `delete_artboard` — Remove an artboard

### Alignment & Distribution
- `align_nodes` — Align nodes (left, center, right, top, middle, bottom)
- `distribute_nodes` — Distribute nodes evenly (horizontal or vertical)

### Fill & Export
- `set_fill` — Set background fill with color, gradient, or image
- `export_image` — Export an artboard as PNG, JPG, SVG, or PDF

### Viewport
- `zoom_to_artboard` — Zoom to fit a specific artboard
- `zoom_to_fit` — Zoom to fit all content
- `set_viewport` — Scroll to a specific position
- `move_artboard` — Change an artboard's position on the canvas

### Document
- `rename_document` — Rename the document
- `new_document` — Create a fresh document

### History
- `undo` — Undo last action
- `redo` — Redo last undone action

### Theme
- `get_theme` — Get current theme colors
- `set_theme` — Set custom theme palette
- `set_theme_mode` — Toggle light/dark mode
- `reset_theme` — Reset to default theme

### Quality
- `audit_design` — Audit the current design for issues (spacing, contrast, layout)
- `repair_design` — Fix issues found by `audit_design`

### Animation
- `list_animation_presets` — Show available animation presets
- `apply_animation_plan` — Apply animations to nodes (staggered entrances, fades, slides, etc.)
- `clear_animations` — Remove all animations

## Sub-Skills

This skill includes three specialized sub-skills loaded automatically for relevant tasks:

### efecto-web-design
Landing pages, dashboards, marketing sites, pricing pages, app UIs. Layout patterns, component structure, responsive design, typography scales, Tailwind best practices.

### efecto-social-media
Instagram carousels, posts, stories, YouTube thumbnails, TikTok covers, Twitter/X images, LinkedIn slides, Pinterest pins. Platform-specific sizing, bold typography, scroll-stopping design.

### efecto-graphic-design
Pitch decks, event posters, business cards, resumes, menus, infographics, invitations, newsletters, email headers, OG images, certificates, documents. Presentation layouts, print-ready sizing, visual hierarchy.

## Workflow Tips

- Start with `create_session` and tell the user to open the URL
- Always `wait_for_connection` before pushing design commands
- Use `create_artboard` with `className: "flex flex-col"` + a reasonable size
- Use `add_section` with JSX + Tailwind for building layouts
- Use `batch_update` for bulk edits instead of individual `update_node` calls
- Use `get_document` to inspect current state and get node IDs for targeting
- After layout is done, use `apply_animation_plan` for motion
- Export with `export_image` when the design is final
