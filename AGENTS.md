# AGENTS.md

## Repository purpose

`torus-visualg` contains a VisuAlg implementation of the classic ASCII torus
animation inspired by Andy Sloane's `donut.c`.

The repository intentionally contains both readable and compact/obfuscated
programs for Linux and Windows. It also contains the Portuguese-BR presentation
used to explain the implementation.

Do not add, document, or depend on the separate generator/obfuscation framework
here. It belongs in another repository.

## Repository layout

- `torus.alg`: compact/obfuscated Linux version.
- `readable-torus.alg`: readable Linux version.
- `torus-for-windows.alg`: compact/obfuscated Windows version.
- `readable-torus-for-windows.alg`: readable Windows version.
- `src/torus-base.alg`: canonical readable maintenance/reference source.
- `scripts/visualg`: Linux Bash wrapper around `delegua --dialeto visualg`.
- `docs/presentation-ptbr.pptx`: maintained Portuguese-BR presentation.
- `docs/assets/`: source and media assets used by the presentation.

Root-level `.alg` files are the user-facing runnable programs. Keep helper tools
under `scripts/`, reference/maintenance source under `src/`, and presentation
material under `docs/`.

## VisuAlg maintenance rules

- Keep Linux and Windows variants mathematically and behaviorally equivalent
  except where terminal/UI behavior requires a platform-specific implementation.
- Make algorithmic changes in the readable/reference version first, then port
  them to the compact files.
- Linux variants may use ANSI terminal escape sequences for in-place redraw.
- Windows variants must not require ANSI cursor control; use VisuAlg-compatible
  redraw such as `limpatela`.
- Avoid `e` as a variable name. It caused parser conflicts in the Linux
  VisuAlg/Delégua workflow used for this project.
- Short/obfuscated sources may use identifiers such as `a`, `b`, `c`, `d`, `f`,
  `g`, `h`, `i`, `j`, `k`, `l`, `m`, `n`, `o`, `p`, `q`, `r`, `s`, `t`, `u`,
  `v`, `w`, `x`, `y`, and `z`, while avoiding reserved/problematic identifiers.
- Preserve output string literals exactly unless output behavior is intentionally
  being changed.
- Prefer syntax known to work in the targeted VisuAlg/Delégua implementation
  over clever language constructs.
- Preserve the torus math, depth-buffer behavior, luminance mapping, output
  dimensions, and animation increments unless a change specifically targets one
  of them.
- For performance-sensitive changes, prefer reduced sampling, incremental
  rotation state, or generation counters only when compatibility has been
  verified in the intended runner.

## Linux helper script

`scripts/visualg` is part of the maintained developer/user experience. Preserve
its behavior unless a change explicitly intends to alter that interface.

The helper:

- is a Bash script;
- launches programs with `delegua --dialeto visualg`;
- accepts a filename with or without the `.alg` suffix;
- keeps the wrapper alive while Delégua runs so it can receive signals and clean
  up terminal state;
- stores `<wrapper-pid> <delegua-pid>` in `/tmp/visualg-$UID.pid`;
- limits helper-managed execution to one VisuAlg process per user;
- detects/removes stale PID files;
- on `SIGINT`, sends `SIGTERM` to the child and exits with status 130;
- on `SIGQUIT`, sends `SIGKILL` to the child and exits with status 131;
- on wrapper `SIGTERM`, sends `SIGTERM` to the child and exits with status 143;
- restores the visible cursor (`ESC[?25h`) on wrapper exit;
- implements `-k` / `--kill` to force-kill the managed Delégua child;
- implements `-h` / `--help` for usage information.

The helper's built-in help describes `Ctrl+Shift+C` as the normal stop key and
`Ctrl+\\` as the emergency stop. Do not assume every terminal emulator maps
`Ctrl+Shift+C` to `SIGINT`; many use it for copy. Documentation should therefore
also mention ordinary `Ctrl+C`/the user's configured SIGINT key and the
`visualg --kill` fallback.

When changing the helper:

1. keep it executable;
2. retain safe quoting around filenames/arguments;
3. retain cleanup on every normal wrapper exit;
4. avoid leaving a stale PID file owned by the current wrapper;
5. preserve argument forwarding to the `.alg` program;
6. test starting by both `file.alg` and extensionless `file`;
7. test graceful stop, force stop, `--kill`, stale PID handling, and the
   single-instance guard;
8. update the Linux instructions in `README.md` when its CLI changes.

Do not replace this script with a wrapper that recursively invokes a command
named `visualg`; its underlying interpreter is Delégua.

## Presentation maintenance

The deck is `docs/presentation-ptbr.pptx`. Treat it as maintained project
content rather than an expendable generated artifact.

Preserve the customizations established for this project:

- Language is Portuguese-BR.
- Begin with the visible torus/animation and movement before introducing the
  math-heavy explanation.
- Introduce `sin()` and `cos()` conceptually before mapping them to code.
- Explain the relationship between the torus geometry, rotation, projection,
  depth buffer, luminance, and ASCII character selection progressively.
- Avoid describing the material itself as “didático”/“didactic”.
- Do not add UI-directed prose such as “clique neste trecho”.
- Prefer editable PowerPoint text, shapes, arrows, and callouts over text baked
  into images.
- Keep chapter and subchapter headings left-aligned.
- Keep image/source captions left-aligned.
- Ensure text is not clipped or cropped after edits.
- Render/review affected slides before committing a presentation change.
- Preserve the torus animation GIF where animation is useful.
- Use rectangles, arrows, and explanatory balloons to associate explanations
  with code; balloons are preferred for explanatory callouts.
- Small code excerpts may link to/detail full-code slides.
- Keep readable ALGO source on hidden/detail slides rather than presenting it as
  a conventional appendix.
- Preserve navigation labels exactly: `Próximo`, `Anterior`, and `Voltar`.
- Preserve the Chapter 2 link text: `Veja também a versão legível`.
- Keep internal navigation functional when slides are inserted, removed, or
  reordered.
- When filenames, formulas, dimensions, variable meanings, or code excerpts
  change, update both visible explanatory slides and any corresponding
  hidden/detail slides.
- If source code shown in slides changes, verify that the slide still matches the
  committed `.alg` source rather than editing the two independently.
- Retain assets under `docs/assets/` when the presentation depends on them.

When editing the presentation, do not casually recreate the whole deck. Make
localized edits where possible so unrelated layout, hyperlinks, animations,
hidden-slide state, and formatting remain intact.

## Validation before committing

For source changes:

- run the readable Linux variant through `scripts/visualg`;
- verify that it animates continuously and terminates cleanly;
- compare compact and readable variants for the intended behavior;
- test Windows-specific changes in a compatible VisuAlg environment when
  possible.

For helper changes:

- run `scripts/visualg --help`;
- test extension and extensionless program names;
- test normal interruption and `--kill`;
- confirm the cursor is visible afterwards;
- confirm `/tmp/visualg-$UID.pid` is removed after wrapper exit.

For presentation changes:

- inspect the edited slides visually;
- inspect hidden/detail slides affected by source changes;
- verify internal navigation links/buttons;
- verify headings and captions remain left-aligned;
- verify no text or code is clipped.

## Commit hygiene

- Keep binary/presentation changes intentional.
- Do not reformat every `.alg` file for a localized behavioral change.
- Keep the readable and compact platform pairs synchronized.
- If the slide deck changes, describe whether the commit changes content,
  navigation, layout, code synchronization, or assets.
- Do not commit runtime PID files or local terminal artifacts.
