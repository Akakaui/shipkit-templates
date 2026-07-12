#!/bin/bash
# Shipkit Agent Templates — Universal Installer
# Detects which AI coding tools are in use and installs appropriate templates.
#
# Usage:
#   bash install.sh                    # auto-detect, install to current dir
#   bash install.sh /path/to/project   # install to specific project
#   bash install.sh --list             # show supported agents
#   bash install.sh --force            # overwrite existing files
#
# Supported agents:
#   Claude Code, Cursor, Cline, Windsurf, Codex CLI, Aider, OpenCode, Antigravity

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR"
TARGET_DIR=""
FORCE=false

# ──────────────────────────────────────────────
# Parse arguments
# ──────────────────────────────────────────────
for arg in "$@"; do
  case "$arg" in
    --list)
      echo "Supported agents:"
      echo "  claude-code    Claude Code (plugin + agents + skills + commands)"
      echo "  cursor         Cursor (MDC rules)"
      echo "  cline          Cline (markdown rules)"
      echo "  windsurf       Windsurf (markdown rules)"
      echo "  codex          Codex CLI (TOML agents)"
      echo "  aider          Aider (conventions + rules)"
      echo "  opencode       OpenCode (agents + skills)"
      echo "  antigravity    Antigravity/Google (rules)"
      exit 0
      ;;
    --force)
      FORCE=true
      ;;
    -*)
      echo "Unknown option: $arg"
      echo "Usage: bash install.sh [--list] [--force] [/path/to/project]"
      exit 1
      ;;
    *)
      TARGET_DIR="$arg"
      ;;
  esac
done

TARGET_DIR="${TARGET_DIR:-.}"

echo "╔══════════════════════════════════════════╗"
echo "║   Shipkit Agent Templates — Installer    ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "Target: $TARGET_DIR"
echo ""

# Track what we install
installed=()

# Helper: copy with optional force
copy_if_needed() {
  local src="$1" dst="$2"
  if [ -f "$dst" ] && [ "$FORCE" = false ]; then
    return 0
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
}

copy_dir_if_needed() {
  local src="$1" dst="$2"
  mkdir -p "$dst"
  if [ "$FORCE" = true ]; then
    cp -r "$src"/* "$dst/" 2>/dev/null || true
  else
    cp -rn "$src"/* "$dst/" 2>/dev/null || true
  fi
}

# ──────────────────────────────────────────────
# Claude Code
# ──────────────────────────────────────────────
if [ -f "$TARGET_DIR/CLAUDE.md" ] || [ -d "$TARGET_DIR/.claude" ]; then
  echo "▸ Claude Code detected — installing plugin..."
  mkdir -p "$TARGET_DIR/.claude/rules" "$TARGET_DIR/.claude/agents" \
           "$TARGET_DIR/.claude/skills" "$TARGET_DIR/.claude/commands" \
           "$TARGET_DIR/.claude/hooks"
  copy_dir_if_needed "$TEMPLATES_DIR/claude-code/.claude" "$TARGET_DIR/.claude"

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

# ──────────────────────────────────────────────
# Cursor
# ──────────────────────────────────────────────
if [ -f "$TARGET_DIR/.cursorrules" ] || [ -d "$TARGET_DIR/.cursor" ]; then
  echo "▸ Cursor detected — installing rules..."
  mkdir -p "$TARGET_DIR/.cursor/rules"
  copy_dir_if_needed "$TEMPLATES_DIR/cursor/.cursor" "$TARGET_DIR/.cursor"
  installed+=("cursor")
fi

# ──────────────────────────────────────────────
# Cline
# ──────────────────────────────────────────────
if [ -f "$TARGET_DIR/.clinerules" ] || [ -d "$TARGET_DIR/.cline" ]; then
  echo "▸ Cline detected — installing rules..."
  mkdir -p "$TARGET_DIR/.clinerules"
  copy_dir_if_needed "$TEMPLATES_DIR/cline/.clinerules" "$TARGET_DIR/.clinerules"
  installed+=("cline")
fi

# ──────────────────────────────────────────────
# Windsurf
# ──────────────────────────────────────────────
if [ -f "$TARGET_DIR/.windsurfrules" ] || [ -d "$TARGET_DIR/.windsurf" ]; then
  echo "▸ Windsurf detected — installing rules..."
  mkdir -p "$TARGET_DIR/.windsurf/rules"
  copy_dir_if_needed "$TEMPLATES_DIR/windsurf/.windsurf" "$TARGET_DIR/.windsurf"
  installed+=("windsurf")
fi

# ──────────────────────────────────────────────
# Codex CLI
# ──────────────────────────────────────────────
if [ -d "$TARGET_DIR/.codex" ] || [ -f "$TARGET_DIR/AGENTS.md" ]; then
  echo "▸ Codex CLI detected — installing agents..."
  mkdir -p "$TARGET_DIR/.codex/agents"
  copy_dir_if_needed "$TEMPLATES_DIR/codex/.codex" "$TARGET_DIR/.codex"
  # Also install AGENTS.md for Codex
  if [ ! -f "$TARGET_DIR/AGENTS.md" ] || [ "$FORCE" = true ]; then
    copy_if_needed "$TEMPLATES_DIR/codex/AGENTS.md" "$TARGET_DIR/AGENTS.md"
  fi
  installed+=("codex")
fi

# ──────────────────────────────────────────────
# Aider
# ──────────────────────────────────────────────
if [ -f "$TARGET_DIR/.aider.conf.yml" ] || [ -d "$TARGET_DIR/.aider.d" ]; then
  echo "▸ Aider detected — installing conventions..."
  mkdir -p "$TARGET_DIR/.aider.d/shipkit"
  copy_if_needed "$TEMPLATES_DIR/aider/CONVENTIONS.md" "$TARGET_DIR/CONVENTIONS.md"
  copy_dir_if_needed "$TEMPLATES_DIR/aider/.aider.d/shipkit" "$TARGET_DIR/.aider.d/shipkit"
  installed+=("aider")
fi

# ──────────────────────────────────────────────
# OpenCode
# ──────────────────────────────────────────────
if [ -f "$TARGET_DIR/opencode.json" ] || [ -d "$TARGET_DIR/.opencode" ]; then
  echo "▸ OpenCode detected — installing agents & skills..."
  mkdir -p "$TARGET_DIR/.opencode/agents" \
           "$TARGET_DIR/.opencode/skills/detect" \
           "$TARGET_DIR/.opencode/skills/build" \
           "$TARGET_DIR/.opencode/skills/deploy" \
           "$TARGET_DIR/.opencode/skills/plan" \
           "$TARGET_DIR/.opencode/skills/architect" \
           "$TARGET_DIR/.opencode/skills/review"
  copy_dir_if_needed "$TEMPLATES_DIR/opencode/.opencode" "$TARGET_DIR/.opencode"
  installed+=("opencode")
fi

# ──────────────────────────────────────────────
# Antigravity
# ──────────────────────────────────────────────
if [ -f "$TARGET_DIR/GEMINI.md" ] || [ -d "$TARGET_DIR/.agents" ]; then
  echo "▸ Antigravity detected — installing rules..."
  mkdir -p "$TARGET_DIR/.agents/rules"
  copy_dir_if_needed "$TEMPLATES_DIR/antigravity/.agents" "$TARGET_DIR/.agents"
  installed+=("antigravity")
fi

# ──────────────────────────────────────────────
# Always install shared AGENTS.md
# ──────────────────────────────────────────────
if [ ! -f "$TARGET_DIR/AGENTS.md" ] || [ "$FORCE" = true ]; then
  echo "▸ Installing shared AGENTS.md..."
  copy_if_needed "$TEMPLATES_DIR/shared/AGENTS.md" "$TARGET_DIR/AGENTS.md"
  installed+=("shared-agents")
else
  echo "▸ AGENTS.md already exists — skipping"
fi

# ──────────────────────────────────────────────
# Summary
# ──────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════"
if [ ${#installed[@]} -eq 0 ]; then
  echo "⚠  No AI coding tools detected in $TARGET_DIR"
  echo ""
  echo "  Supported: Claude Code, Cursor, Cline, Windsurf, Codex, Aider, OpenCode, Antigravity"
  echo ""
  echo "  Options:"
  echo "    ./install.sh /path/to/project    Install to a specific directory"
  echo "    ./install.sh --list              Show supported agents"
  echo "    ./install.sh --force             Overwrite existing files"
  echo ""
  echo "  Or specify a target directory that contains one of:"
  echo "    CLAUDE.md, .cursorrules, .clinerules, .windsurfrules,"
  echo "    .codex/, .aider.d/, opencode.json, GEMINI.md"
else
  echo "✓  Installed for: ${installed[*]}"
  echo ""
  echo "  Installed files:"
  [ -d "$TARGET_DIR/.claude" ] && echo "    .claude/              — Claude Code (rules, agents, skills, commands)"
  [ -d "$TARGET_DIR/.cursor" ] && echo "    .cursor/rules/        — Cursor (MDC rules)"
  [ -d "$TARGET_DIR/.clinerules" ] && echo "    .clinerules/          — Cline (markdown rules)"
  [ -d "$TARGET_DIR/.windsurf" ] && echo "    .windsurf/rules/      — Windsurf (markdown rules)"
  [ -d "$TARGET_DIR/.codex" ] && echo "    .codex/               — Codex CLI (TOML agents)"
  [ -d "$TARGET_DIR/.aider.d" ] && echo "    .aider.d/shipkit/     — Aider (conventions)"
  [ -d "$TARGET_DIR/.opencode" ] && echo "    .opencode/            — OpenCode (agents, skills)"
  [ -d "$TARGET_DIR/.agents" ] && echo "    .agents/rules/        — Antigravity (rules)"
  [ -f "$TARGET_DIR/AGENTS.md" ] && echo "    AGENTS.md             — Cross-tool shared rules"
  echo ""
  echo "  Next steps:"
  echo "    1. Review AGENTS.md for your project's pipeline needs"
  echo "    2. Customize agent files for your team"
  echo "    3. Test with: /ship (Claude Code) or describe a task to your tool"
fi
echo "═══════════════════════════════════════════"
