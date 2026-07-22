# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Project goal

This is a Game Boy Color (GBC) game. The build output must be a ROM that
runs on GBC emulators (and ideally real hardware). The project is brand
new — no source, toolchain, or build system has been chosen yet.

## Status

Early setup. Nothing has been scaffolded. When picking up the next piece
of work here, expect to make foundational decisions (toolchain, project
layout, build tooling) rather than find them already in place.

## Toolchain

Not yet decided. The standard options for GBC homebrew are:

- **GBDK-2020** — C toolchain targeting Game Boy / GBC, easiest to work
  with if the game logic should be written in C.
- **RGBDS** — assembler-based toolchain, more control, more boilerplate.

Pick one before writing game code, and record the choice (and why) here
once made.

## Building and running

Once a toolchain exists, this section should document:
- the exact build command(s) that produce the `.gbc` ROM
- which emulator to use to run/verify the ROM (e.g. BGB, SameBoy, mGBA),
  and the command to launch it headlessly if available
- how to tell the build actually succeeded (ROM header/checksum, emulator
  boots to a known screen, etc.) since GBC ROMs can't be "tested" with
  a normal test runner

Keep this section up to date as soon as a build exists — an empty section
here is a signal the project is still pre-scaffold.

## Reference material

- `docs/HARDWARE.md` — CGB hardware spec summary (CPU, memory map, PPU,
  APU, cartridge header). Use it for quick lookups; defer to Pan Docs
  (https://gbdev.io/pandocs/) for exact register bit layouts.

## Conventions

- Target hardware is Game Boy Color specifically (not DMG-only, not GBA).
  Prefer CGB-aware APIs/features where the toolchain offers them.
- Keep ROM size and RAM usage in mind — this is an embedded target with
  hard memory limits, not a general-purpose environment.
