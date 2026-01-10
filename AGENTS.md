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

---

## Build / Lint / Test Commands

**This repository has NO build, lint, or test commands.**

- No application code exists
- No package.json, requirements.txt, or other dependency files
- No compiled output
- No test suites

### What Does Run

The only automated process is a GitHub Actions workflow:

```yaml
# .github/workflows/metrics.yaml
# Triggers:
#   - Hourly (cron: "0 * * * *")
#   - Push to master
#   - Pull request to master
#   - Manual dispatch

# Action: Generates github-metrics.svg using lowlighter/metrics
```

**To test workflow changes locally**: Not directly possible. Push to a branch and create a PR, or use `workflow_dispatch` to trigger manually.

---

## Code Style Guidelines

### YAML Files (`.github/workflows/*.yaml`)

**Formatting**:
- 2-space indentation
- Use `yaml` extension (not `yml`)
- Quote strings that could be misinterpreted (cron expressions)

**Structure**:
```yaml
name: Workflow Name

on:
  schedule: [{ cron: "0 * * * *" }]  # Inline for single items
  push:
    branches: [master]               # Inline for short arrays
  workflow_dispatch:                  # Empty triggers at end

jobs:
  job-name:
    name: Human readable name
    runs-on: ubuntu-latest
    environment:
      name: production
    permissions:
      contents: write                # Minimal required permissions
    steps:
      - uses: action/name@version
        with:
          # Options grouped by category with comments
```

**Conventions observed**:
- Lowercase job names with hyphens: `metrics-job`
- Comments explain non-obvious settings
- Group related options with blank line separators
- Use `@latest` for trusted actions (lowlighter/metrics)

### Markdown Files (`README.md`)

**Formatting**:
- Tables for side-by-side content
- Inline HTML for images with fallbacks: `<picture><img ... /></picture>`
- External image URLs for dynamic content (stats, streaks)
- Local paths for generated content (`/github-metrics.svg`)

**Table structure**:
```markdown
| Header 1                              | Header 2                                  |
| :-------------------------------------| :---------------------------------------- |
| Content with left align               | Content with left align                   |
```

---

## Working with This Repository

### Making Changes

1. **README.md**: Edit directly. Changes reflect on GitHub profile immediately after push.

2. **metrics.yaml**: Test changes by:
   - Creating a PR (triggers workflow on `pull_request`)
   - Using "Run workflow" button in GitHub Actions tab (`workflow_dispatch`)

3. **Secrets required**: `METRICS_TOKEN` - GitHub PAT with appropriate scopes for metrics collection.

### Commit Message Convention

Based on git history, automated commits follow:
```
Update github-metrics.svg - [Skip GitHub Action]
```

For manual commits, use descriptive messages:
```
feat: add new stats widget to README
chore: update metrics workflow configuration
fix: correct timezone setting in metrics
```

---

## GitHub Actions Workflow Details

### Trigger Schedule

- **Hourly updates**: `cron: "0 * * * *"` (at minute 0 of every hour)
- **On push**: To `master` branch
- **On PR**: Targeting `master` branch
- **Manual**: Via `workflow_dispatch`

### Metrics Configuration

The workflow uses [lowlighter/metrics](https://github.com/lowlighter/metrics):

**Enabled plugins**:
- `base`: header, activity, community, repositories, metadata
- `plugin_isocalendar`: Half-year contribution calendar
- `plugin_traffic`: Repository traffic stats

**Disabled plugins** (available but turned off):
- `plugin_habits`: Coding habits analysis
- `plugin_languages`: Language breakdown
- `plugin_stargazers`: Star history

### Environment

- **Runner**: `ubuntu-latest`
- **Environment**: `production`
- **Timezone**: `Asia/Kolkata`
- **Permissions**: `contents: write` (to commit updated SVG)

---

## Common Tasks

### Add a New Stats Widget to README

1. Find the widget/badge service (shields.io, github-readme-stats, etc.)
2. Add the image URL to README.md table
3. Test locally by previewing markdown
4. Commit and push

### Modify Metrics Generation

1. Edit `.github/workflows/metrics.yaml`
2. Reference [lowlighter/metrics documentation](https://github.com/lowlighter/metrics)
3. Push to branch or trigger manual run
4. Verify `github-metrics.svg` output

### Enable a Disabled Plugin

```yaml
# Change from:
plugin_languages: no

# To:
plugin_languages: yes
# Configure additional options as needed
```

---

## Important Notes

- **No local development environment needed** - This is a static content repository
- **SVG is auto-generated** - Don't edit `github-metrics.svg` manually
- **Secrets are in GitHub** - `METRICS_TOKEN` stored in repository secrets
- **Branch is `master`** - Not `main` (check before pushing)
