# torus-visualg

ASCII torus animation implemented in VisuAlg, inspired by Andy Sloane's classic
`donut.c`.

The repository keeps readable and intentionally obfuscated versions for both
Linux terminal execution and the classic Windows VisuAlg environment, together
with the Portuguese-BR presentation that explains the implementation.

## Repository layout

| Path | Target | Purpose |
| --- | --- | --- |
| `torus.alg` | Linux CLI | Intentionally compact/obfuscated torus animation. |
| `readable-torus.alg` | Linux CLI | Readable equivalent of `torus.alg`; preferred for studying and maintenance. |
| `torus-for-windows.alg` | Windows VisuAlg | Intentionally compact/obfuscated Windows-compatible variant. |
| `readable-torus-for-windows.alg` | Windows VisuAlg | Readable equivalent of the Windows variant. |
| `src/torus-base.alg` | Source/reference | Readable maintenance baseline shared conceptually by the platform variants. |
| `scripts/visualg` | Linux | Helper/wrapper for running VisuAlg programs through Delégua. |
| `docs/presentation-ptbr.pptx` | Documentation | Portuguese-BR presentation explaining the torus and its implementation. |
| `docs/assets/` | Documentation | Assets used by or kept with the presentation. |

## Linux requirements

The Linux programs are intended to run with Delégua's VisuAlg dialect. The
helper script invokes:

```bash
delegua --dialeto visualg <program.alg>
```

Therefore, `delegua` must be installed and available in `PATH`.

The Linux variants also assume a terminal that understands ANSI escape
sequences because the animation redraws frames in place.

## Linux helper script

`scripts/visualg` is the recommended way to run the `.alg` files on Linux. It
is a small Bash process wrapper around Delégua, not another VisuAlg
implementation.

It provides several conveniences needed by the continuously running animation:

- runs `delegua --dialeto visualg` while keeping the wrapper process alive;
- accepts either `program.alg` or `program` when the `.alg` file exists;
- stores the wrapper and Delégua process IDs in `/tmp/visualg-$UID.pid`;
- allows only one helper-managed VisuAlg process per user at a time;
- removes stale PID files automatically;
- forwards normal termination to the Delégua child process;
- provides an emergency force-kill path;
- restores the terminal cursor when the wrapper exits;
- provides `--help` and `--kill` commands.

Run it directly from the repository:

```bash
./scripts/visualg torus.alg
./scripts/visualg readable-torus.alg
```

The extension may be omitted:

```bash
./scripts/visualg torus
./scripts/visualg readable-torus
```

For convenient use as the `visualg` command, install or symlink the helper into
a directory in your `PATH`, for example:

```bash
mkdir -p ~/.local/bin
ln -sf "$PWD/scripts/visualg" ~/.local/bin/visualg
```

Then run:

```bash
visualg torus
```

Run `visualg --help` to display the wrapper's built-in usage information.

### Terminating a Linux animation

For the terminal key mapping used when this helper was developed:

- `Ctrl+Shift+C` reaches the wrapper as `SIGINT` and requests graceful
  termination of the Delégua process;
- `Ctrl+\` reaches it as `SIGQUIT` and immediately force-kills the Delégua
  process.

Terminal emulators may assign `Ctrl+Shift+C` to copy instead. In that case,
use the terminal's configured key for sending `SIGINT` (normally `Ctrl+C`), or
use the explicit kill command from another terminal:

```bash
visualg --kill
```

`visualg --kill` reads the PID file and sends `SIGKILL` to the currently
managed Delégua child process. Use it as an emergency stop rather than the
normal termination path.

The wrapper restores the visible cursor on exit. If a program is killed outside
the wrapper or the terminal is otherwise left in an unusual state, the standard
terminal command below can still be useful:

```bash
reset
```

## Running without the helper on Linux

The helper is optional. The same program can be started directly with Delégua:

```bash
delegua --dialeto visualg torus.alg
```

However, direct execution does not provide the helper's PID management,
single-instance check, emergency `--kill` command, or explicit cursor cleanup.

## Running on Windows VisuAlg

Open either of the Windows variants in the classic VisuAlg application:

```text
torus-for-windows.alg
readable-torus-for-windows.alg
```

Start the program from the VisuAlg interface. Stop it using the IDE's stop
facility or by closing/interruption mechanisms supported by the installed
VisuAlg version.

The Linux helper is not needed on Windows.

## Differences between the versions

### Obfuscated vs. readable

`torus.alg` and `torus-for-windows.alg` are intentionally compact and use short
identifiers, preserving the spirit of Andy Sloane's obfuscated donut program.
They are useful as the final compact examples, but they are not the preferred
files for understanding or changing the algorithm.

`readable-torus.alg` and `readable-torus-for-windows.alg` express the same
algorithm with clearer structure, names, and comments. Use these when studying,
debugging, or modifying the program.

### Linux vs. Windows

The Linux versions target a terminal and use ANSI terminal behavior to redraw
the animation in place. This allows continuous output without clearing and
recreating a GUI output window for every frame.

The Windows variants avoid depending on ANSI cursor control because the classic
VisuAlg environment may not interpret those sequences as terminal controls.
They instead use VisuAlg-compatible screen clearing/redraw behavior such as
`limpatela`.

As a consequence, the two platform families should render the same torus and
use the same underlying mathematics, while their display/update mechanisms are
platform-specific.

## Maintenance workflow

Make behavioral changes in the readable/reference code first:

1. Update `src/torus-base.alg` and/or the appropriate readable platform file.
2. Test `readable-torus.alg` on Linux with `scripts/visualg`.
3. Test `readable-torus-for-windows.alg` in Windows VisuAlg when the change
   affects portable behavior.
4. Apply the equivalent behavior to `torus.alg` and
   `torus-for-windows.alg` without sacrificing their intentionally compact
   style.
5. Update `docs/presentation-ptbr.pptx` whenever filenames, formulas, variable
   meanings, rendering behavior, dimensions, or explanatory code excerpts
   change.

Do not introduce dependencies on the separate code-generation/obfuscation
project into this repository.
