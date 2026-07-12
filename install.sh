#!/bin/bash
# Shipkit Agent Templates — Installer
# Detects which AI coding tools are in use and installs appropriate templates
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR"
TARGET_DIR="${1:-.}"

echo "╔════════════════════════════════════════╗"
echo "║     Shipkit Agent Templates Installer  ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Track what we install
installed=()

# ──────────────────────────────────────────────
# Detect and install per tool
# ──────────────────────────────────────────────

# Claude Code
if [ -f "$TARGET_DIR/CLAUDE.md" ] || [ -d "$TARGET_DIR/.claude" ]; then
  echo "▸ Claude Code detected — installing plugin..."
  mkdir -p "$TARGET_DIR/.claude/rules" "$TARGET_DIR/.claude/agents" "$TARGET_DIR/.claude/skills" "$TARGET_DIR/.claude/commands" "$TARGET_DIR/.claude/hooks"
  cp -r "$TEMPLATES_DIR/claude-code/.claude/"* "$TARGET_DIR/.claude/" 2>/dev/null || true
  # Install plugin manifest as zip
  if command -v zip &>/dev/null; then
    mkdir -p /tmp/shipkit-plugin
    cp -r "$TEMPLATES_DIR/claude-code/.claude-plugin/"* /tmp/shipkit-plugin/
    (cd /tmp/shipkit-plugin && zip -r "$TARGET_DIR/shipkit-claude-plugin.mcpb" . -x ".*")
    rm -rf /tmp/shipkit-plugin
    echo "  ✓ Plugin manifest: shipkit-claude-plugin.mcpb"
  fi
  installed+=("claude-code")
fi

# Cursor
if [ -f "$TARGET_DIR/.cursorrules" ] || [ -d "$TARGET_DIR/.cursor" ]; then
  echo "▸ Cursor detected — installing rules..."
  mkdir -p "$TARGET_DIR/.cursor/rules"
  cp -r "$TEMPLATES_DIR/cursor/.cursor/"* "$TARGET_DIR/.cursor/" 2>/dev/null || true
  installed+=("cursor")
fi

# Cline
if [ -f "$TARGET_DIR/.clinerules" ] || [ -d "$TARGET_DIR/.cline" ]; then
  echo "▸ Cline detected — installing rules..."
  mkdir -p "$TARGET_DIR/.clinerules"
  cp -r "$TEMPLATES_DIR/cline/.clinerules/"* "$TARGET_DIR/.clinerules/" 2>/dev/null || true
  installed+=("cline")
fi

# Windsurf
if [ -f "$TARGET_DIR/.windsurfrules" ] || [ -d "$TARGET_DIR/.windsurf" ]; then
  echo "▸ Windsurf detected — installing rules..."
  mkdir -p "$TARGET_DIR/.windsurf/rules"
  cp -r "$TEMPLATES_DIR/windsurf/.windsurf/"* "$TARGET_DIR/.windsurf/" 2>/dev/null || true
  installed+=("windsurf")
fi

# Codex CLI
if [ -d "$TARGET_DIR/.codex" ]; then
  echo "▸ Codex CLI detected — installing agents..."
  mkdir -p "$TARGET_DIR/.codex/agents"
  cp -r "$TEMPLATES_DIR/codex/.codex/"* "$TARGET_DIR/.codex/" 2>/dev/null || true
  installed+=("codex")
fi

# Aider
if [ -f "$TARGET_DIR/.aider.conf.yml" ] || [ -d "$TARGET_DIR/.aider.d" ]; then
  echo "▸ Aider detected — installing conventions..."
  mkdir -p "$TARGET_DIR/.aider.d/shipkit"
  cp "$TEMPLATES_DIR/aider/CONVENTIONS.md" "$TARGET_DIR/CONVENTIONS.md" 2>/dev/null || true
  cp -r "$TEMPLATES_DIR/aider/.aider.d/shipkit/"* "$TARGET_DIR/.aider.d/shipkit/" 2>/dev/null || true
  installed+=("aider")
fi

# OpenCode
if [ -f "$TARGET_DIR/opencode.json" ] || [ -d "$TARGET_DIR/.opencode" ]; then
  echo "▸ OpenCode detected — installing agents & skills..."
  mkdir -p "$TARGET_DIR/.opencode/agents" "$TARGET_DIR/.opencode/skills/detect" "$TARGET_DIR/.opencode/skills/build"
  cp -r "$TEMPLATES_DIR/opencode/.opencode/"* "$TARGET_DIR/.opencode/" 2>/dev/null || true
  installed+=("opencode")
fi

# Antigravity
if [ -f "$TARGET_DIR/GEMINI.md" ] || [ -d "$TARGET_DIR/.agents" ]; then
  echo "▸ Antigravity detected — installing rules..."
  mkdir -p "$TARGET_DIR/.agents/rules"
  cp -r "$TEMPLATES_DIR/antigravity/.agents/"* "$TARGET_DIR/.agents/" 2>/dev/null || true
  installed+=("antigravity")
fi

# ──────────────────────────────────────────────
# Always install shared AGENTS.md
# ──────────────────────────────────────────────
if [ ! -f "$TARGET_DIR/AGENTS.md" ]; then
  echo "▸ Installing shared AGENTS.md..."
  cp "$TEMPLATES_DIR/shared/AGENTS.md" "$TARGET_DIR/AGENTS.md"
  installed+=("shared-agents")
else
  echo "▸ AGENTS.md already exists — skipping (review shared/AGENTS.md for updates)"
fi

# ──────────────────────────────────────────────
# Summary
# ──────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════"
if [ ${#installed[@]} -eq 0 ]; then
  echo "⚠ No AI coding tools detected in $TARGET_DIR"
  echo "  Supported: Claude Code, Cursor, Cline, Windsurf, Codex, Aider, OpenCode, Antigravity"
  echo "  Run this script from your project root, or pass the path as argument:"
  echo "    ./install.sh /path/to/project"
else
  echo "✓ Installed for: ${installed[*]}"
  echo ""
  echo "Next steps:"
  echo "  1. Review AGENTS.md for your project's pipeline needs"
  echo "  2. Customize .claude/agents/, .codex/agents/, etc. for your team"
  echo "  3. Test with: /ship (Claude Code) or describe a task to your tool"
fi
echo "═══════════════════════════════════════════"
