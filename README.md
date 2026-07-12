# Shipkit Agent Templates

Multi-agent development pipeline rules for AI coding agents. One pipeline, every tool.

## What This Does

Injects the Shipkit 6-phase pipeline (Detect → Plan → Architect → Build → Review → Ship) into whichever AI coding tools your team uses. Write the rules once, deploy everywhere.

## Supported Tools

| Tool | Rule Location | Agent Support | Notes |
|------|--------------|---------------|-------|
| **Claude Code** | `.claude/rules/`, `.claude/agents/`, `.claude/skills/`, `.claude/commands/` | `.claude-plugin/plugin.json` | Desktop Extensions + Skills Marketplace |
| **Cursor** | `.cursor/rules/*.mdc` | `@shipkit-planner`, `@shipkit-reviewer` agents | YAML header format |
| **Cline** | `.clinerules/*.md` | `@shipkit-planner`, `@shipkit-reviewer` | Plain markdown |
| **Windsurf** | `.windsurf/rules/*.md` | `@shipkit-planner`, `@shipkit-reviewer` | Markdown, XML tags optional |
| **Codex CLI** | `AGENTS.md` + `.codex/agents/*.toml` | `planner.toml`, `reviewer.toml` | TOML agent config |
| **Aider** | `CONVENTIONS.md` + `.aider.d/shipkit/*.md` | N/A | Convention-driven |
| **OpenCode** | `.opencode/agents/*.md` + `.opencode/skills/` | Agent + skill system | Markdown agents |
| **Antigravity** | `.agents/rules/*.md` + `GEMINI.md` | Rules-based | Google's agent system |

## Quick Start

```bash
# From your project root:
/path/to/shipkit-templates/install.sh .

# Or from anywhere:
/path/to/shipkit-templates/install.sh /path/to/your/project
```

The installer:
1. Detects which AI tools are in use
2. Copies appropriate rule files
3. Creates agent definitions where supported
4. Installs the shared `AGENTS.md` (cross-tool standard)

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
│   │   ├── agents/            # planner, architect, builder, reviewer
│   │   ├── skills/            # ship, detect, plan, deploy
│   │   ├── commands/          # /ship, /review
│   │   └── hooks.json         # Pre/post tool use hooks
│   └── settings.json          # Permission config
├── cursor/
│   └── .cursor/rules/         # shipkit.mdc, detect.mdc, build.mdc
├── cline/
│   └── .clinerules/           # shipkit.md, detect.md, build.md
├── windsurf/
│   └── .windsurf/rules/       # shipkit.md, detect.md, build.md
├── codex/
│   ├── AGENTS.md
│   └── .codex/agents/         # planner.toml, reviewer.toml
├── aider/
│   ├── CONVENTIONS.md
│   └── .aider.d/shipkit/      # detect.md, build.md
├── opencode/
│   └── .opencode/
│       ├── agents/            # shipkit.md
│       └── skills/            # detect/, build/
├── antigravity/
│   └── .agents/rules/         # shipkit.md, detect.md, build.md
└── install.sh                 # Universal installer
```

## Customization

### Adding Your Own Rules
Edit `shared/AGENTS.md` for cross-tool rules. Tool-specific rules live in each tool's directory.

### Adding New Agents
Each tool has its own agent format:
- **Claude Code**: `.claude/agents/*.md` (markdown with YAML frontmatter)
- **Cursor/Cline/Windsurf**: Use `@agent-name` references in rules
- **Codex**: `.codex/agents/*.toml` (TOML with instructions)
- **OpenCode**: `.opencode/agents/*.md` (markdown)

### Pipeline Phases
The 6 phases are:
1. **Detect** — Classify intent, identify domain, check existing patterns
2. **Plan** — Break into atomic subtasks with acceptance criteria
3. **Architect** — Design within existing patterns, validate interfaces
4. **Build** — Implement subtasks, run tests after each
5. **Review** — Security, quality, performance, accessibility checks
6. **Ship** — Full test suite, build, create PR

Stop if any phase fails. Never skip ahead.

## License

MIT
