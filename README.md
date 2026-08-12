# flix-hello

[![Build and Test](https://github.com/wstein/flix-hello/actions/workflows/build-and-test.yaml/badge.svg)](https://github.com/wstein/flix-hello/actions/workflows/build-and-test.yaml)
[![Flix](https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fwstein%2Fflix-hello%2Fmain%2F.flixw%2Flock.toml&query=%24.compiler.version&label=flix&color=blue)](.flixw/lock.toml)
[![flixw](https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fwstein%2Fflix-hello%2Fmain%2F.flixw%2Flock.toml&query=%24.wrapperVersion&label=flixw&color=blue)](https://github.com/wstein/flixw)
[![Java](https://img.shields.io/badge/java-21%2B-blue)](https://adoptium.net/temurin/releases/?version=21)
[![License](https://img.shields.io/github/license/wstein/flix-hello?color=blue)](LICENSE)

A GitHub template for starting a [Flix](https://flix.dev) project, and a
worked example of [`flixw`](https://github.com/wstein/flixw) — a
repository-local bootstrap that fetches the compiler the project pins instead
of relying on whatever `flix` happens to be installed.

## Quick start

Click **Use this template**, clone your copy, and run it:

```sh
./flixw run          # .\flixw.cmd run on Windows
```

The only prerequisite is a JDK, Java 21 or newer. You do not need Flix
installed: the first command downloads `flix.jar` for the version pinned in
`.flixw/lock.toml`, checks it against the SHA-256 committed alongside it, caches
it outside the repository, and runs it. Later commands reuse the cache.

```sh
./flixw check        # type-check; the fast feedback loop
./flixw test         # run every @Test function under test/
./flixw format       # reformat sources in place
./flixw validate     # the wrapper's own consistency checks; what CI runs first
./flixw doctor       # validate, plus the full picture, for bug reports
```

## What is in here

```
.
├── src/
│   └── Main.flix                 the pure greeting function and the main that prints it
├── test/
│   └── TestMain.flix             @Test functions covering greeting
├── .flixw/
│   ├── flixw.java                the wrapper proper — one dependency-free Java file
│   └── lock.toml                 the exact compiler, its URL, and its SHA-256
├── .github/
│   ├── workflows/
│   │   └── build-and-test.yaml   validate, check and test, on three platforms
│   └── dependabot.yml            keeps the workflow's pinned action digests current
├── flix.toml                     package metadata and the lowest Flix version accepted
├── flixw                         the POSIX shim
├── flixw.cmd                     the cmd.exe trampoline
├── AGENTS.md                     instructions for coding agents; CLAUDE.md and
│                                 .github/copilot-instructions.md point at it
└── LICENSE                       Apache-2.0, with the copyright line to replace
```

`flix.toml` states a *floor* and `.flixw/lock.toml` states the *pin*. They are
allowed to differ — any pin at or above the floor satisfies it — but
`./flixw validate` fails when the pin does not, so the two cannot drift apart
unnoticed.

## What the wrapper is and is not

`flixw` never patches, forks or links against the Flix compiler. It fetches the
stock `flix.jar` by URL, verifies the digest before every use, and runs it as an
opaque process. Moving to another compiler is `./flixw pin <version>`, which
rewrites the lock; updating the wrapper itself is
`./flixw wrapper --upgrade`.

Two things are worth knowing before you adopt it. `flixw` is upstream-described
as experimental, and it is code your project executes on every build — which is
why it is committed in full and pinned by version and digest rather than curled
at run time. Read `.flixw/flixw.java` if that matters to you; it is deliberately
one file.

## Continuous integration

`.github/workflows/build-and-test.yaml` runs `validate`, `check` and `test`
through the wrapper on Linux, macOS and Windows — the Windows leg exercises
`flixw.cmd`, the others the POSIX shim. It installs a JDK and nothing else,
which is the same starting position a new contributor is in. Actions are pinned
to commit digests and kept current by Dependabot.

There is no formatting gate: the pinned compiler's `format` has no check-only
mode, so run `./flixw format` before you commit.

## After you template this

1. `flix.toml` — set `name`, `description`, `version` and `authors`.
2. `LICENSE` — replace the copyright line, or the whole license.
3. `src/` and `test/` — replace the greeting with your own code.
4. This README, including the badge URLs — they name `wstein/flix-hello` and
   will report this repository's state, not yours, until you change them.

The Flix and `flixw` badges read `.flixw/lock.toml` directly, so re-pinning with
`./flixw pin <version>` updates them without touching this file.

## License

Apache-2.0. See [LICENSE](LICENSE).
