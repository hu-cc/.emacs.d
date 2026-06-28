# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Emacs configuration directory (`user-emacs-directory`). The config uses **literate programming**: the canonical source is `config.org` (an org-mode file containing emacs-lisp source blocks). On startup, `init.el` calls `org-babel-load-file` on `config.org`, which tangles it to `config.el` and loads the result. **Always edit `config.org`, never `config.el` directly** — the latter is generated.

## File Architecture

```
early-init.el    — Runs before init.el; GC tuning, GUI cleanup, frame settings
init.el          — Entry point: sets up package.el, installs use-package, loads config.org
config.org       — Literate config (canonical source); tangled to config.el
config.el        — Generated from config.org; do not edit
```

## Startup Flow

1. `early-init.el` — maximize GC threshold (reset after init), disable package-enable-at-startup (manual init in init.el), hide GUI chrome, set frame size
2. `init.el` — configure package archives (Tsinghua mirrors), bootstrap `use-package`, set `use-package-always-ensure t`, then `org-babel-load-file` on `config.org`
3. `config.org` — all actual configuration organized as org headings with `BEGIN_SRC emacs-lisp` blocks

## Package Architecture

All packages are installed via `package.el` into `elpa/` and configured with `use-package`. The key stack:

- **Completion UI**: Vertico (vertical minibuffer) + Corfu (in-buffer popup) + Cape (extra Capf backends) + Orderless (flexible matching) + Consult (enhanced navigation commands). Narrowing key is `<`.
- **LSP**: Eglot (built-in) with clangd for C/C++ modes. Format-on-save via `eglot-format-buffer`.
- **Git**: Magit, bound to `C-x g`.
- **Notes**: Org-mode + Org-roam (with sqlite-builtin backend). Org-roam DB stored in `user-emacs-directory`. Daily notes and roam files live under `D:/OneDrive/note-taking/`.
- **Theme**: Zenburn with a custom compact mode-line format.
- **Search**: Ctrlf replaces isearch.

## Key Design Decisions

- `use-package-always-ensure t` — all packages auto-install; use `:ensure nil` for built-in packages (e.g., eglot)
- C coding style defaults to `"linux"` with `c-basic-offset` aliased to `tab-width` (8)
- Completion uses `orderless` as primary style with `basic` fallback; file completion uses `partial-completion`
- GC threshold: `most-positive-fixnum` during init → 800KB after init (early-init.el), then 100MB in config.org
- `create-lockfiles nil` and `make-backup-files nil` — no lock/backup files
- UTF-8 everywhere (`prefer-coding-system 'utf-8`)

## How to Reload Config

After editing `config.org`:
- `M-x org-babel-tangle` to regenerate `config.el`, then `M-x eval-buffer` on it, OR
- Restart Emacs (the full path reads config.org fresh)

To test a single change without full reload: evaluate the relevant sexp with `C-x C-e` or `M-x eval-last-sexp`.

## Path Dependencies

- `D:/OneDrive/note-taking/roam` — Org-roam files directory
- `D:/OneDrive/note-taking/daily` — Org-roam daily notes
- `D:/` — default-directory
- Org-roam DB: `~/.emacs.d/org-roam.db`
- ELPA mirrors: Tsinghua University mirrors (`mirrors.tuna.tsinghua.edu.cn`)
