# Shipkit Agent Templates

Multi-agent development pipeline rules for AI coding agents. One pipeline, every tool.

---

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Supported Agents](#supported-agents)
- [Installation](#installation)
  - [Universal Installer](#universal-installer)
  - [Per-Agent Install](#per-agent-install)
    - [Claude Code](#claude-code)
    - [Cursor](#cursor)
    - [Cline](#cline)
    - [Windsurf](#windsurf)
    - [Codex CLI](#codex-cli)
    - [Aider](#aider)
    - [OpenCode](#opencode)
    - [Antigravity](#antigravity)
- [The 6-Phase Pipeline](#the-6-phase-pipeline)
- [File Structure](#file-structure)
- [Customization](#customization)
  - [Adding Your Own Rules](#adding-your-own-rules)
  - [Adding New Agents](#adding-new-agents)
  - [Pipeline Phases](#pipeline-phases)
- [What Each Agent Gets](#what-each-agent-gets)
- [FAQ](#faq)
- [License](#license)

---

## Overview

Shipkit injects a structured 6-phase development pipeline into whichever AI coding tools your team uses:

```
Detect → Plan → Architect → Build → Review → Ship
```

Write the rules once, deploy everywhere. The same quality gates, code standards, and security checks apply regardless of which agent you use.

---

## Quick Start

```bash
# From your project root:
/path/to/shipkit-templates/install.sh .

# Or from anywhere:
/path/to/shipkit-templates/install.sh /path/to/your/project

# See what's available:
/path/to/shipkit-templates/install.sh --list

# Overwrite existing files:
/path/to/shipkit-templates/install.sh --force
```

The installer auto-detects which AI tools are in use and installs the appropriate templates.

---

## Supported Agents

| Agent | Format | Rule Location | Agents | Skills | Commands |
|-------|--------|--------------|--------|--------|----------|
| **Claude Code** | Plugin manifest + markdown | `.claude-plugin/` + `.claude/` | `planner.md`, `architect.md`, `reviewer.md` | `detect`, `build`, `deploy` | `/ship`, `/review` |
| **Cursor** | MDC with YAML frontmatter | `.cursor/rules/*.mdc` | — | — | — |
| **Cline** | Plain markdown | `.clinerules/*.md` | — | — | — |
| **Windsurf** | Plain markdown | `.windsurf/rules/*.md` | — | — | — |
| **Codex CLI** | TOML + AGENTS.md | `.codex/agents/*.toml` + `AGENTS.md` | `planner`, `architect`, `builder`, `reviewer`, `shipper` | — | — |
| **Aider** | Conventions + rules | `CONVENTIONS.md` + `.aider.d/` | — | — | — |
| **OpenCode** | Agents + skills | `.opencode/agents/*.md` + `.opencode/skills/` | `shipkit`, `planner`, `architect`, `reviewer` | `detect`, `build`, `deploy`, `plan`, `architect`, `review` | — |
| **Antigravity** | Rules + GEMINI.md | `.agents/rules/*.md` + `GEMINI.md` | — | — | — |

---

## Installation

### Universal Installer

The `install.sh` script auto-detects your AI tools and installs templates:

```bash
# Install to current directory
bash install.sh

# Install to a specific project
bash install.sh /path/to/project

# Show supported agents
bash install.sh --list

# Overwrite existing files
bash install.sh --force
```

**Detection heuristics:**

| Agent | Detected when |
|-------|--------------|
| Claude Code | `CLAUDE.md` exists or `.claude/` directory exists |
| Cursor | `.cursorrules` exists or `.cursor/` directory exists |
| Cline | `.clinerules` exists or `.cline/` directory exists |
| Windsurf | `.windsurfrules` exists or `.windsurf/` directory exists |
| Codex CLI | `.codex/` directory exists or `AGENTS.md` exists |
| Aider | `.aider.conf.yml` exists or `.aider.d/` directory exists |
| OpenCode | `opencode.json` exists or `.opencode/` directory exists |
| Antigravity | `GEMINI.md` exists or `.agents/` directory exists |

### Per-Agent Install

#### Claude Code

**Files installed:**
```
.claude-plugin/
  plugin.json              # Plugin manifest
.claude/
  rules/
    pipeline.md            # 6-phase pipeline enforcement
    detect.md              # Detect phase rules
    build.md               # Build standards
  agents/
    planner.md             # Detect + Plan agent
    architect.md           # Architect agent
    reviewer.md            # Review agent
  skills/
    detect/SKILL.md        # Detect phase skill
    build/SKILL.md         # Build phase skill
    deploy/SKILL.md        # Ship phase skill
  commands/
    ship.md                # /ship command (full pipeline)
    review.md              # /review command
  hooks/                   # Pre/post hooks (empty, ready for config)
  settings.json            # Permission config
```

**Usage:**
- `/ship fix the login bug` — runs full pipeline
- `/review` — reviews staged changes
- Agents available via `@shipkit-planner`, `@shipkit-architect`, `@shipkit-reviewer`

**Install manually:**
```bash
cp -r claude-code/.claude /path/to/project/.claude
cp -r claude-code/.claude-plugin /path/to/project/.claude-plugin
cp claude-code/.claude/settings.json /path/to/project/.claude/settings.json
```

#### Cursor

**Files installed:**
```
.cursor/
  rules/
    shipkit.mdc            # Main pipeline rules
    detect.mdc             # Detect phase
    build.mdc              # Build standards
    architect.mdc          # Architect phase
    planner.mdc            # Planning phase
    reviewer.mdc           # Review phase
```

**MDC format:**
```yaml
---
description: What this rule does
globs: ["**/*.{ts,tsx,js,jsx,py,rs,go}"]
alwaysApply: false
---
```

**Install manually:**
```bash
cp -r cursor/.cursor /path/to/project/.cursor
```

#### Cline

**Files installed:**
```
.clinerules/
  shipkit.md               # Main pipeline rules
  detect.md                # Detect phase
  build.md                 # Build standards
  architect.md             # Architect phase
  planner.md               # Planning phase
  reviewer.md              # Review phase
  workflows/               # Workflow definitions (empty, ready for config)
```

**Install manually:**
```bash
cp -r cline/.clinerules /path/to/project/.clinerules
```

#### Windsurf

**Files installed:**
```
.windsurf/
  rules/
    shipkit.md             # Main pipeline rules
    detect.md              # Detect phase
    build.md               # Build standards
    architect.md           # Architect phase
    planner.md             # Planning phase
    reviewer.md            # Review phase
```

**Install manually:**
```bash
cp -r windsurf/.windsurf /path/to/project/.windsurf
```

#### Codex CLI

**Files installed:**
```
AGENTS.md                  # Cross-tool shared rules
.codex/
  agents/
    planner.toml           # Detect + Plan agent
    architect.toml         # Architect agent
    builder.toml           # Build agent
    reviewer.toml          # Review agent
    shipper.toml           # Ship agent
```

**TOML agent format:**
```toml
[agent]
description = "What this agent does"
model = "codex-mini"
tools = ["container", "filesystem", "shell"]

[instructions]
task = """
[Agent instructions]
"""
```

**Usage:** Type `$planner`, `$architect`, `$builder`, `$reviewer`, `$shipper` to invoke agents.

**Install manually:**
```bash
cp codex/AGENTS.md /path/to/project/AGENTS.md
cp -r codex/.codex /path/to/project/.codex
```

#### Aider

**Files installed:**
```
CONVENTIONS.md             # Global conventions
.aider.d/
  shipkit/
    architect.md           # Architect phase
    build.md               # Build standards
    detect.md              # Detect phase
    planner.md             # Planning phase
    reviewer.md            # Review phase
```

**Install manually:**
```bash
cp aider/CONVENTIONS.md /path/to/project/CONVENTIONS.md
cp -r aider/.aider.d /path/to/project/.aider.d
```

#### OpenCode

**Files installed:**
```
.opencode/
  agents/
    shipkit.md             # Main pipeline agent
    planner.md             # Detect + Plan agent
    architect.md           # Architect agent
    reviewer.md            # Review agent
  skills/
    detect/SKILL.md        # Detect phase skill
    build/SKILL.md         # Build phase skill
    deploy/SKILL.md        # Ship phase skill
    plan/SKILL.md          # Planning phase skill
    architect/SKILL.md     # Architect phase skill
    review/SKILL.md        # Review phase skill
```

**Install manually:**
```bash
cp -r opencode/.opencode /path/to/project/.opencode
```

#### Antigravity

**Files installed:**
```
GEMINI.md                  # Global rules (root level)
.agents/
  rules/
    shipkit.md             # Main pipeline rules
    detect.md              # Detect phase
    build.md               # Build standards
    architect.md           # Architect phase
    planner.md             # Planning phase
    reviewer.md            # Review phase
```

**Install manually:**
```bash
cp antigravity/GEMINI.md /path/to/project/GEMINI.md
cp -r antigravity/.agents /path/to/project/.agents
```

---

## The 6-Phase Pipeline

Every feature goes through these phases IN ORDER. Stop if any phase fails.

| Phase | What Happens | Output |
|-------|-------------|--------|
| **1. Detect** | Classify intent, domain, scope; grep for existing patterns | Structured task object |
| **2. Plan** | Break into atomic subtasks (≤30 min), define acceptance criteria, flag risks | Execution plan |
| **3. Architect** | Design within patterns, validate interfaces, check dependencies | Technical design |
| **4. Build** | Implement subtasks, run tests after each, follow code style | Working code + tests |
| **5. Review** | Security, quality, performance, accessibility checks | Pass/fail verdict |
| **6. Ship** | Full test suite, build, create PR | Deployable artifact |

---

## File Structure

```
shipkit-templates/
├── shared/
│   └── AGENTS.md              # Cross-tool universal rules
├── claude-code/
│   ├── .claude-plugin/
│   │   └── plugin.json        # Plugin manifest
│   ├── .claude/
│   │   ├── rules/             # Pipeline, detect, build rules
│   │   ├── agents/            # planner, architect, reviewer
│   │   ├── skills/            # detect, build, deploy
│   │   ├── commands/          # /ship, /review
│   │   ├── hooks.json         # Pre/post tool use hooks
│   │   └── settings.json      # Permission config
├── cursor/
│   └── .cursor/rules/         # shipkit.mdc, detect.mdc, build.mdc, etc.
├── cline/
│   └── .clinerules/           # shipkit.md, detect.md, build.md, etc.
├── windsurf/
│   └── .windsurf/rules/       # shipkit.md, detect.md, build.md, etc.
├── codex/
│   ├── AGENTS.md
│   └── .codex/agents/         # planner.toml, architect.toml, etc.
├── aider/
│   ├── CONVENTIONS.md
│   └── .aider.d/shipkit/      # detect.md, build.md, etc.
├── opencode/
│   └── .opencode/
│       ├── agents/            # shipkit.md, planner.md, etc.
│       └── skills/            # detect/, build/, deploy/, etc.
├── antigravity/
│   ├── GEMINI.md
│   └── .agents/rules/         # shipkit.md, detect.md, etc.
└── install.sh                 # Universal installer
```

---

## Customization

### Adding Your Own Rules

Edit `shared/AGENTS.md` for cross-tool rules. Tool-specific rules live in each tool's directory.

### Adding New Agents

Each tool has its own agent format:
- **Claude Code**: `.claude/agents/*.md` with YAML frontmatter (`name`, `description`, `tools`)
- **Cursor/Cline/Windsurf**: Use `@agent-name` references in rules
- **Codex**: `.codex/agents/*.toml` with `[agent]` and `[instructions]` sections
- **OpenCode**: `.opencode/agents/*.md` (plain markdown)

### Pipeline Phases

The 6 phases are:
1. **Detect** — Classify intent, identify domain, check existing patterns
2. **Plan** — Break into atomic subtasks with acceptance criteria
3. **Architect** — Design within existing patterns, validate interfaces
4. **Build** — Implement subtasks, run tests after each
5. **Review** — Security, quality, performance, accessibility checks
6. **Ship** — Full test suite, build, create PR

Stop if any phase fails. Never skip ahead.

---

## What Each Agent Gets

| Agent | Pipeline Rules | Agents | Skills | Commands | Config |
|-------|---------------|--------|--------|----------|--------|
| Claude Code | `pipeline.md`, `detect.md`, `build.md` | `planner`, `architect`, `reviewer` | `detect`, `build`, `deploy` | `/ship`, `/review` | `plugin.json`, `settings.json` |
| Cursor | `shipkit.mdc`, `detect.mdc`, `build.mdc`, `planner.mdc`, `architect.mdc`, `reviewer.mdc` | — | — | — | — |
| Cline | `shipkit.md`, `detect.md`, `build.md`, `planner.md`, `architect.md`, `reviewer.md` | — | — | — | — |
| Windsurf | `shipkit.md`, `detect.md`, `build.md`, `planner.md`, `architect.md`, `reviewer.md` | — | — | — | — |
| Codex | `AGENTS.md` | `planner`, `architect`, `builder`, `reviewer`, `shipper` | — | — | — |
| Aider | `CONVENTIONS.md` | — | — | — | `.aider.d/` |
| OpenCode | `shipkit.md` | `planner`, `architect`, `reviewer` | `detect`, `build`, `deploy`, `plan`, `architect`, `review` | — | — |
| Antigravity | `shipkit.md`, `detect.md`, `build.md`, `planner.md`, `architect.md`, `reviewer.md` | — | — | — | `GEMINI.md` |

---

## FAQ

**Q: Can I use multiple agents on the same project?**
A: Yes. The installer detects all agents in use and installs templates for each. The shared `AGENTS.md` ensures consistent rules across all tools.

**Q: Will this conflict with my existing rules?**
A: The installer creates new files in standard locations. It won't overwrite existing files unless you use `--force`.

**Q: Can I customize the pipeline?**
A: Yes. Edit the rule files in each agent's directory. The `shared/AGENTS.md` file provides cross-tool consistency.

**Q: Which agents support skills/commands?**
A: Claude Code supports agents, skills, and commands. OpenCode supports agents and skills. Codex supports TOML agents. The others use rule files only.

**Q: How do I test if the pipeline is working?**
A: Run `/ship` (Claude Code) or describe a task to your tool. The agent should follow the 6-phase pipeline and produce structured output.

---

## License

MIT
