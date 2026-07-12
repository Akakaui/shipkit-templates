---
name: bridge
description: Cross-system collaboration between OPEX and CODE agents. Use when a task spans both business and technical domains.
---
# BRIDGE — OPEX ↔ CODE Communication Protocol

## PURPOSE

Enables OPEX and CODE systems to collaborate on hybrid
tasks that require both business and technical expertise.

## WHEN THIS LOADS

- User requests something that spans both systems
- "Write a blog post about [project]"
- "Create a landing page with copy"
- "Announce our new feature on social media"
- "Build a tool for [business need]"
- "Write documentation for [technical thing]"
- "Launch this product"

## BRIDGE PROTOCOL

### Step 1: Identify Which System Leads

Determine which system is PRIMARY for this task:

  CONTENT-LED tasks → OPEX leads, CODE supports
  "Write a blog post about our new feature"
  OPEX writes the post, CODE provides feature details

  CODE-LED tasks → CODE leads, OPEX supports
  "Build a landing page with copy"
  CODE builds the page, OPEX writes the copy

### Step 2: Pull Context From Both Systems

Before executing, load context from BOTH:

  From CODE:
  - What was built (features, architecture, stack)
  - What's working (status, deployment, demo URL)
  - Technical specs (API, endpoints, data model)
  - Screenshots, demos, code examples

  From OPEX:
  - Brand voice and tone
  - Target audience
  - Current content strategy
  - Platform requirements (IG, Twitter, blog)
  - Messaging framework

### Step 3: Execute With Handoff

Run the task with clear handoff between systems:

  CODE-LED Example: "Build landing page with copy"

  1. CODE builds page structure (HTML/React/Next.js)
  2. CODE provides technical specs to OPEX
  3. OPEX writes copy (headline, subhead, CTA, benefits)
  4. OPEX hands copy back to CODE
  5. CODE integrates copy into page
  6. CODE deploys
  7. OPEX creates social announcement

  CONTENT-LED Example: "Write blog post about project"

  1. CODE provides: project summary, features, tech stack, architecture
  2. OPEX writes: blog post, social posts, email announcement
  3. OPEX hands back to CODE: any technical content that needs review
  4. CODE reviews technical accuracy
  5. OPEX publishes

### Step 4: Quality Check Both Sides

After completion, verify:

  CODE side:
  - [ ] Technical accuracy
  - [ ] No bugs introduced
  - [ ] Deployment successful
  - [ ] Documentation updated

  OPEX side:
  - [ ] Brand voice consistency
  - [ ] Persuasive copy
  - [ ] Platform-specific formatting
  - [ ] CTA is clear

## HYBRID TASK EXAMPLES

### Blog Post About a Project

User: "Write a blog post about our new SaaS dashboard"

CODE provides:
  - Project: SaaS Dashboard
  - Features: Real-time analytics, team collaboration, API integration
  - Stack: Next.js, PostgreSQL, Vercel
  - Demo: https://app.example.com
  - Status: Live, 100 beta users

OPEX writes:
  - Title: "Introducing Our SaaS Dashboard"
  - Subhead: "Real-time analytics for modern teams"
  - Body: Problem → Solution → Features → CTA
  - Social posts for Twitter, LinkedIn, Instagram
  - Email announcement

CODE reviews:
  - Technical accuracy check
  - Link verification
  - Screenshot validation

### Feature Announcement

User: "Announce our new API on social media"

CODE provides:
  - API: RESTful, 50+ endpoints
  - Docs: https://docs.example.com
  - Auth: API key + OAuth
  - Rate limits: 1000 req/min

OPEX writes:
  - Twitter thread (5 tweets)
  - LinkedIn post
  - Instagram carousel
  - Email to existing users

### Build a Tool

User: "Build me a lead scoring tool"

CODE builds:
  - Tool structure
  - Scoring algorithm
  - UI components
  - API endpoints

OPEX operates:
  - Content strategy for the tool
  - Landing page copy
  - Social promotion
  - User onboarding flow

## HANDOFF FORMAT

When one system hands off to the other, use this format:

  HANDOFF — [FROM] → [TO]

  Task: [what needs to be done]
  Context: [relevant info from source system]
  Expected output: [what TO system should produce]
  Constraints: [brand guidelines, technical limits]

## CONFLICT RESOLUTION

If OPEX and CODE disagree:

  1. Technical accuracy wins (CODE)
  2. Brand voice wins (OPEX)
  3. User experience wins (both)
  4. When stuck → ask user

## RULES

- ALWAYS identify which system leads
- ALWAYS pull context from both systems
- ALWAYS do handoff format
- ALWAYS quality check both sides
- NEVER skip the handoff step
- NEVER assume the other system's context