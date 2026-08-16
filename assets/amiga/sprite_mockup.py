from PIL import Image,ImageOps
import os

import shared,bitplanelib

sprite_names = shared.get_sprite_names()

this_dir = os.path.dirname(os.path.abspath(__file__))

tilesdir = os.path.join(this_dir,os.pardir,"sheets","sprites")

def doit(binname):
    with open(os.path.join(this_dir,binname),"rb") as f:
        contents = f.read()


    side = 16
    transparent = (0,0,0)  # not possible to get it in the game

    blank_image = Image.new("RGB",(side,side))
    for i in range(side):
        for j in range(side):
            blank_image.putpixel((i,j),transparent)


    def load_tileset(image_name,side,dump_prefix=""):
        full_image_path = os.path.join(tilesdir,image_name)
        if os.path.exists(full_image_path):
            tiles_1 = Image.open(full_image_path)
            nb_rows = tiles_1.size[1] // side
            nb_cols = tiles_1.size[0] // side

            dumpdir = "dumps"

            tileset_1 = []
            k=0
            for j in range(nb_rows):
                for i in range(nb_cols):
                    img = Image.new("RGBA",(side,side))
                    img.paste(tiles_1,(-i*side,-j*side))
                    tileset_1.append(img)
                    k += 1

            return tileset_1
        else:
            return None

    ts_title_list = [load_tileset(f"pal_{p:02x}.png",16) for p in range(64)]
    layer = Image.new("RGB",(224,288),(130,130,130))

    buffered_spriteram = contents

    used_sprites = set()




##    move.b    (TARGET_SPRITE_LX,a0),d0
##    move.b    (TARGET_SPRITE_HX,a0),d3
##    bclr    #7,d3            | d4 is the color now
##
##    moveq    #0,d2
##    moveq    #0,d4
##    move.b    (TARGET_SPRITE_CODE,a0),d2
##    move.b    d2,d4
##    and.b    #3,d4        | flipX/Y attributes
##    lsr.b    #2,d2        | code

    filtered = []
    for offs in range(0x14,0x14+7*2,2):
        code_and_attributes = buffered_spriteram[offs]
        tile_code = code_and_attributes >> 2
        attributes = code_and_attributes & 3
        color_and_hx = buffered_spriteram[offs+0x801]
        tile_color = color_and_hx & 0x3F
        sy = buffered_spriteram[offs+0x800]
        sy = 256-sy
        sx = buffered_spriteram[offs+1] + ((color_and_hx & 0x80) << 1)
        flipx = attributes & 1
        flipy = attributes & 2

        name = sprite_names.get(tile_code,"unknown")

        used_sprites.add(tile_code)

        #tile_color = 1  # fix color
        sheet = ts_title_list[1]

        if sheet and tile_code:
            img = sheet[tile_code]
            if flipx:
                img = ImageOps.mirror(img)
            if flipy:
                img = ImageOps.flip(img)


            filtered.append(buffered_spriteram[offs:offs+2])
            print(f"offset={offs:04x}, code={tile_code:02x}, clut={tile_color}: name={name}, x={sx}, y={sy} flipx={flipx} flipy={flipy}")
            layer.paste(img,box=(sx,sy))

    layer.save(f"{binname}.png")


doit("rallyx_ram")






