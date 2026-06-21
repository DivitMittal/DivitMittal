---
description: Project knowledge for the DivitMittal GitHub profile README repository
applyTo: "**"
---

## Repository Overview

This is a **GitHub Profile README repository** (`DivitMittal/DivitMittal`).
It's a special repository that GitHub displays on the user's profile page.

**Purpose**: Display GitHub statistics and metrics on profile page.

### Repository Contents

```
.
├── README.md                    # Profile README (displayed on GitHub profile)
├── github-metrics.svg           # Auto-generated metrics image
├── AGENTS.md                    # This file
└── .github/
    └── workflows/
        └── metrics.yaml         # GitHub Actions workflow
```

## Build / Lint / Test Commands

**This repository has NO build, lint, or test commands.** No application code exists.

The only automated process is a GitHub Actions workflow that generates `github-metrics.svg` using `lowlighter/metrics`:
- Triggers: hourly cron, push to master, PR to master, manual dispatch

## Code Style Guidelines

### YAML Files (`.github/workflows/*.yaml`)
- 2-space indentation, `yaml` extension (not `yml`)
- Lowercase job names with hyphens: `metrics-job`

### Markdown Files (`README.md`)
- Tables for side-by-side content
- Inline HTML for images: `<picture><img ... /></picture>`

## Working with This Repository

- **README.md**: Edit directly. Changes reflect on GitHub profile immediately after push.
- **Secrets required**: `METRICS_TOKEN` — GitHub PAT with appropriate scopes.
- **Branch is `master`** — not `main` (check before pushing).
- **SVG is auto-generated** — don't edit `github-metrics.svg` manually.

## GitHub Actions Workflow Details

**Enabled plugins**: base (header, activity, community, repositories, metadata), isocalendar, traffic

**Runner**: ubuntu-latest | **Timezone**: Asia/Kolkata | **Permissions**: contents: write
