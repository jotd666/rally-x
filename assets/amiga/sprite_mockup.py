from PIL import Image,ImageOps
import os

import shared,bitplanelib

sprite_names = shared.get_sprite_names()

this_dir = os.path.dirname(os.path.abspath(__file__))

tilesdir = os.path.join(this_dir,os.pardir,"sheets","sprites")

radar_attributes = [0,0,0,0,9,1,1,1,1,1,1,1,1,0,0,0]
radar_attributes = [int(x,16) for x in "00 00 00 00 0F 0D 0D 0C 0C 0C 0D 0C 0D 00 00 00".split()]
radar_attributes = [int(x,16) for x in "00 00 00 00 0E 0C 0C 0C 0C 0C 0C 0D 0D 00 00 00".split()]


def doit(binname):
    with open(os.path.join(this_dir,binname),"rb") as f:
        contents = f.read()


    side = 16
    transparent = (0,0,0)  # not possible to get it in the game

    blank_image = Image.new("RGB",(side,side),transparent)


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
    layer = Image.new("RGB",(288,256),(130,130,130))

    buffered_spriteram = contents

    used_sprites = set()




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

#    m_radarx = m_videoram + 0x20 = 0x8020
#    m_radary = m_radarx + 0x800 = 0x8820
    radarx=0x20
    radary=0x820

    for offs in range(0x14,0x20):
        radarattr = radar_attributes[offs & 0xF]
        x = buffered_spriteram[radarx+offs]
        dx = (~radarattr & 0x01) << 8
        x += dx
        oy = buffered_spriteram[radary+offs]
        if oy:
            y = 253 - oy
            code = ((radarattr & 0x0e) >> 1) ^ 0x07
            print(f"X={x:04x} Y={y:04x} code={code}")
            color = (255,0,255) if code else (0,0,0)
            layer.putpixel((x,y),color)
            layer.putpixel((x+1,y+1),color)
            layer.putpixel((x,y+1),color)
            layer.putpixel((x+1,y),color)

    layer.save(f"{binname}.png")


doit("rallyx_ram_7cars")






