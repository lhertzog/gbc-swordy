#include <gb/gb.h>
#include <gb/cgb.h>

// Solid 8x8 tile — all pixels map to color index 0
const unsigned char solid_tile[] = {
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
};

void main(void) {
    set_bkg_data(0, 1, solid_tile);
    fill_bkg_rect(0, 0, 20, 18, 0);

    palette_color_t pal[4] = {
        RGB(0, 15, 31),   // teal — visible on GBC
        RGB(0, 0, 0),
        RGB(0, 0, 0),
        RGB(0, 0, 0)
    };
    set_bkg_palette(0, 1, pal);

    SHOW_BKG;
    DISPLAY_ON;

    while(1) {
        wait_vbl_done();
    }
}
