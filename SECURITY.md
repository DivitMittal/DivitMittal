# Security Policy

## Scope

This is a GitHub profile README repository. It contains a single GitHub Actions workflow that generates `github-metrics.svg` using a `METRICS_TOKEN` secret.

The attack surface is minimal — no servers, no application code, no user data.

## Reporting a Vulnerability

If you find a security issue (e.g. a workflow step that could expose the `METRICS_TOKEN`):

1. Open a **GitHub issue** with the label `security`.
2. Include a description and impact assessment.

## Supported Versions

Only the latest commit on `master` is supported.
