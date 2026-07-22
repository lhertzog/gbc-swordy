# gbc-swordy

Game Boy Color game built with [GBDK-2020](https://github.com/gbdk-2020/gbdk-2020).

## Cheatsheet

### Build

```bash
# Compile and link → produces build/swordy.gbc
make

# Clean build artifacts
make clean

# Full rebuild from scratch
make clean && make
```

### Run in emulator

```bash
# Launch ROM in mGBA
flatpak run io.mgba.mGBA build/swordy.gbc
```

### Build + run in one shot

```bash
make && flatpak run io.mgba.mGBA build/swordy.gbc
```

## Toolchain

- **Compiler:** GBDK-2020 (`lcc`) — installed at `/usr/share/gbdk-2020`
- **Emulator:** mGBA 0.10.5 (Flatpak `io.mgba.mGBA`)
- **Output:** `build/swordy.gbc` (32KB ROM)

## Project layout

```
src/        C source files
build/      compiled output (generated, not committed)
Makefile    build rules
```
