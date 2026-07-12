---
name: bootstrap
description: Startup sequence and session initialization for the OPEX system. Use when beginning a new session or loading the operating system.
---

# BOOTSTRAP SKILL — v2

Last updated: 2026-07-06
Version: 2
Scope: MANDATORY — must be loaded at the start of EVERY new session

## PURPOSE

This file is mandatory at every session start. It orients you in the
OPEX Business Operating System before any work begins.

After loading this skill, execute the STARTUP SEQUENCE below in order.

---

## STARTUP SEQUENCE

Execute these steps in order.

### Step 0 — Load user identity
Read: `~/.config/opencode/TOOLS.md`
This tells you what tools are installed and configured.

Read: `/home/ubuntu/opex-private/business/config/` (if exists)
For brand, design, tone, and posting schedule.

### Step 1 — Load session state
Read: `/home/ubuntu/opex-private/business/memory/session.state.md`
This is your orientation — identity, mission, client pipeline, machine status,
MCP integration status, and next steps.

### Step 2 — Load active goals
Read: `/home/ubuntu/Akaka content business/goals.memory.md`
This tells you what the user is currently working toward.
Every task must connect to an active goal.

### Step 3 — Load recent performance
Read: `/home/ubuntu/opex-private/business/memory/performance.memory.md`
This tells you what has been working and what has not.
Use this to inform every content and strategy decision.

### Step 4 — Load day tracker
Read: `/home/ubuntu/opex-private/business/memory/day-tracker.md`
This tells you where we are in the content production journey.
Use the greeting table to adapt your tone to the current phase.

### Step 5 — Load additional memory files
Read the INDEX at `/home/ubuntu/opex-private/business/memory/INDEX.md`
for the full catalog of available memory files.

Key files to pre-load based on context:
- `01-brand-and-design.md` — brand identity
- `04-human-voice-rules.md` — voice and tone
- `05-tone-and-protocol.md` — communication protocol
- `03-goals-and-missions.md` — detailed missions
- `07-profile-knowledge.md` — platform profiles
- `08-client-segments.md` — target clients

### Step 6 — Check Qdrant health
Verify the Qdrant vector database is running on port 6333.
Check collections: goals, knowledge, performance, methods-log, skills-log,
hooks-pi, yt-copywriting.

### Step 7 — Check Notion calendar
Fetch today's view from Notion to see if there's content scheduled.

### Step 8 — Welcome greeting
After all steps complete, greet with an appropriate message based on day-tracker phase.

---

## FOLDER MAP

```
~/.config/opencode/           — system config, skills, tools
  TOOLS.md                      — installed tools reference
  skills/                       — skill files
  memory/                       — system memory

/home/ubuntu/Akaka content business/
  goals.memory.md               — active goals and targets

/home/ubuntu/opex-private/
  business/
    config/                     — brand, design, tone configs
    memory/                     — all memory, state, tracker files
      session.state.md          — session orientation
      day-tracker.md            — content day progression
      goals.memory.md           — detailed goals
      performance.memory.md     — performance data
      INDEX.md                  — catalog of all memory files
    skills/                     — business skills
    stack/                      — stack documentation
  opex/                         — agent definitions
```

## RULES

1. Never operate from memory alone — always read files before acting
2. If a file version header looks outdated, flag it
3. If a critical file is missing, report it and suggest creating it
4. Always connect every task to an active goal from goals.memory.md
