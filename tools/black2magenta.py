from PIL import Image,ImageOps
import pathlib

# MAME gfx save edition is cool but cannot differentiate background color from black.
# this is pretty f**ing annoying, fortunately, there's always a CLUT in the set which makes the difference
# here it's monochrome palette index 0xD that saves us.

this_dir = pathlib.Path(__file__).absolute().parent

src_sprite_dir = this_dir / ".." / "assets" / "sheets" / "sprites_black"
dst_sprite_dir = this_dir / ".." / "assets" / "sheets" / "sprites"

yellow_image = Image.open(src_sprite_dir / "pal_0A.png")

yellow_pixels = set()

# this palette has the nice property of having black not merged with background
# black colors in other palettes are there yellow, so we can backport the black color in other palettes
for x in range(yellow_image.size[0]):
    for y in range(yellow_image.size[1]):
        p = yellow_image.getpixel((x,y))
        if p == (222,0,0):
            yellow_pixels.add((x,y))

for i in [1]+list(range(10,16)):
    imgname = f"pal_{i:02X}.png"
    src = src_sprite_dir / imgname
    dst = dst_sprite_dir / imgname

    src_image = Image.open(src)
    dst_image = Image.new("RGB",yellow_image.size)
    for x in range(yellow_image.size[0]):
        for y in range(yellow_image.size[1]):
            p = src_image.getpixel((x,y))
            if p == (0,0,0):
                # black: what do do?
                if (x,y) in yellow_pixels:
                    pass
                else:
                    p = (254,0,254)  # bkack => magenta but not full magenta to avoid conflicts
            dst_image.putpixel((x,y),p)

    dst_image.save(dst)
