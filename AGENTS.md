# Lazzerini Custom AL Workspace

## Scope
- This workspace is a Microsoft Dynamics 365 Business Central AL project.
- Keep instructions short and project-specific; link to existing docs instead of duplicating them.

## Project conventions
- Use `app.json` as the source of truth for app metadata, dependency versions, id ranges, and runtime.
- Keep custom object IDs inside the configured `idRanges` in `app.json`.
- Report objects live in `Report/` and layouts in `ReportLayouts/`; keep dataset fields and layout field references in sync.
- Page extensions that launch reports should stay close to the related report object and use the existing action naming pattern.
- Preserve the existing Italian naming style for user-facing labels unless a change request says otherwise.

## Validation
- Prefer `al_build` before shipping or when touching multiple AL objects.
- Use `al_getdiagnostics` to inspect warnings and errors after AL changes.
- When a report layout changes, verify the paired AL dataset columns and RDLC field names together.

## Avoid
- Do not edit generated artifacts such as `.app` packages, PDFs, or temporary export folders unless the goal is to regenerate them.
- Do not introduce new object IDs outside the existing range without updating `app.json` first.

## Helpful references
- [app.json](app.json)
- [REPORTS_CREATED.md](REPORTS_CREATED.md)