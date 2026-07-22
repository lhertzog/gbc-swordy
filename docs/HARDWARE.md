# Game Boy Color Hardware Specification (reference)

Summary of the CGB hardware this project targets. Source of truth for
anything not covered here is Pan Docs (https://gbdev.io/pandocs/), the
community reference for Game Boy / Game Boy Color development.

## CPU

- Core: Sharp SM83 — a custom 8-bit core with an instruction set that is a
  hybrid of the Intel 8080 and Zilog Z80 (not a true Z80).
- Clock speed:
  - Normal speed: 4.194304 MHz (same as original DMG Game Boy).
  - CGB double speed mode: 8.388608 MHz — entered by writing to the `KEY1`
    register and executing `STOP`. Only available on CGB hardware/CGB-mode
    games.
- Registers: 8-bit `A, B, C, D, E, H, L`, paired as 16-bit `AF, BC, DE, HL`,
  plus 16-bit `SP` (stack pointer) and `PC` (program counter).

## Memory map

| Range         | Size  | Contents                                              |
|---------------|-------|--------------------------------------------------------|
| 0000–3FFF     | 16 KB | ROM bank 00 (fixed)                                    |
| 4000–7FFF     | 16 KB | ROM bank 01–NN (switchable via cartridge MBC)          |
| 8000–9FFF     | 8 KB  | VRAM — bank 0 or 1, switchable in CGB mode via `VBK`   |
| A000–BFFF     | 8 KB  | External RAM (cartridge, if present, may be banked)    |
| C000–CFFF     | 4 KB  | WRAM bank 0                                            |
| D000–DFFF     | 4 KB  | WRAM bank 1–7, switchable in CGB mode via `SVBK`       |
| E000–FDFF     | —     | Echo RAM (mirror of C000–DDFF; unused, do not rely on) |
| FE00–FE9F     | 160 B | OAM — sprite attribute table (40 entries × 4 bytes)    |
| FEA0–FEFF     | —     | Unusable                                               |
| FF00–FF7F     | —     | I/O registers                                          |
| FF80–FFFE     | 127 B | HRAM (high RAM, fast/DMA-safe scratch space)           |
| FFFF          | 1 B   | Interrupt Enable register (`IE`)                       |

CGB-mode totals (vs. original DMG):

- **WRAM**: 32 KB total (8 × 4 KB banks) vs. 8 KB on DMG.
- **VRAM**: 16 KB total (2 × 8 KB banks) vs. 8 KB on DMG.

## Graphics (PPU)

- Screen resolution: 160 × 144 pixels.
- Tiles: 8×8 pixels each; up to 384 addressable tiles per VRAM bank.
  - VRAM bank 0: 384 tiles + two 32×32 background/window tile maps
    (9800–9BFF, 9C00–9FFF).
  - VRAM bank 1 (CGB only): another 384 tiles + BG map color/attribute data
    (palette, bank, flip, priority) for the bank 0 maps.
- Sprites (OBJ): 8×8 or 8×16, up to 40 total, max 10 rendered per scanline.
- CGB color palettes:
  - 8 background palettes × 4 colors, via `BCPS/BCPD` (aka `BGPI/BGPD`).
  - 8 object palettes × 4 colors (color 0 transparent), via `OCPS/OCPD`.
  - Each color is 15-bit RGB (5 bits per channel) chosen from a total space
    of 32,768 colors; up to 56 distinct colors on screen at once (32 BG +
    32 OBJ minus shared transparency/overlap in practice).
- CGB adds VRAM-to-VRAM DMA for tile/map updates: General Purpose DMA and
  HBlank DMA, controlled via `HDMA1`–`HDMA5`.

## Audio (APU)

Four channels, mixed to stereo output (per-channel left/right panning via
`NR51`, master volume via `NR50`):

1. **Channel 1** — pulse wave with frequency sweep.
2. **Channel 2** — pulse wave (no sweep).
3. **Channel 3** — programmable/custom wave (32 × 4-bit samples).
4. **Channel 4** — noise (LFSR-based).

## Interrupts

Five sources, in priority order: VBlank, LCD STAT, Timer, Serial, Joypad.
Each has an enable bit in `IE` (FFFF) and a request flag in `IF` (FF0F).

## Cartridge header

- Header occupies 0100–014F in ROM bank 00.
- `0143` — CGB flag: `$80` = supports CGB and DMG, `$C0` = CGB only.
- Includes title, licensee code, cartridge/MBC type, ROM size, RAM size,
  destination code, and a header checksum the boot ROM validates.

## Sources

- [Pan Docs — Specifications](https://gbdev.io/pandocs/Specifications.html)
- [Pan Docs — Memory Map](https://gbdev.io/pandocs/Memory_Map.html)
- [Game Boy Technical Data (gbdev wiki)](https://gbdev.gg8.se/wiki/articles/Game_Boy_Technical_Data)
- [Game Boy / Color Architecture — A Practical Analysis (copetti.org)](https://www.copetti.org/writings/consoles/game-boy/)

(Fetched via search summaries — this session's network policy blocks direct
fetches to these hosts. Re-verify against Pan Docs directly if precise
register bit layouts are needed for implementation.)
