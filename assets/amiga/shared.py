from PIL import Image,ImageOps
import os,sys,bitplanelib,subprocess,json,pathlib,collections

this_dir = pathlib.Path(__file__).absolute().parent

data_dir = this_dir / ".." / ".."

src_dir = this_dir / ".." / ".." / "src" / "amiga"

sheets_path = this_dir / ".." / "sheets"
dump_dir = this_dir / "dumps"

used_sprite_cluts_file = this_dir / "used_sprite_cluts.json"
used_tile_cluts_file = this_dir / "used_tile_cluts.json"
used_graphics_dir = this_dir / "used_graphics"

sprite_clut_b = [(0, 0, 0), (222, 0, 0), (255, 255, 0), (0, 104, 0)]

orange = (222,151,71)
black = (0,0,0)

sprite_names = dict()

NB_TILES = 256
NB_SPRITES = 64
NB_CLUTS = 64

NB_TARGET_SPRITES = 6


NB_SPRITES = 0x100
NB_TILES = 0x300


hw_sprite_cluts = collections.defaultdict(list)
main_tile_cluts = collections.defaultdict(list)
status_tile_cluts = collections.defaultdict(list)


def imgopen(i):
    p = sheets_path / "tiles" / f"pal_{i:02x}.png"
    return Image.open(p) if p.exists() else None

def read_used_tiles(dump_it):


    try:
        with open(used_graphics_dir / "used_main_tiles","rb") as f:
            for index in range(NB_TILES):
                d = f.read(NB_CLUTS)  # nb cluts aligned with 32
                cluts = [i for i,c in enumerate(d) if c]
                if cluts:
                    add_tile(main_tile_cluts,index,cluts=cluts)
    except OSError:
        pass
    try:
        with open(used_graphics_dir / "used_status_tiles","rb") as f:
            for index in range(NB_TILES):
                d = f.read(NB_CLUTS)  # nb cluts aligned with 32
                cluts = [i for i,c in enumerate(d) if c]
                if cluts:
                    add_tile(status_tile_cluts,index,cluts=cluts)
    except OSError:
        pass


    # add all letters & digits for some known cluts
    for tile_index in range(ord('A'),ord('Z')+1):
        add_tile(main_tile_cluts,tile_index,[9,0xA,0x26])
    for tile_index in range(0,10):
        add_tile(main_tile_cluts,tile_index,[9,0xA,0x26])
        add_tile(status_tile_cluts,tile_index,[0x33,0x26])
        #status_tile_cluts[tile_index].extend([9,0xA])


    for i in range(0x3C,0x40):
        add_hw_sprite(i,"car",[0xB])
    add_hw_sprite(0x38,"game",[0xB])
    add_hw_sprite(0x39,"over",[0xB])
    add_hw_sprite(0x3B,"blank",[1,0xB])

    if dump_it:

        with open(dump_dir / "used_main_tiles.json","w") as f:
            tile_cluts_dict = {hex(k):[hex(x) for x in v] for k,v in main_tile_cluts.items() if v}
            json.dump(tile_cluts_dict,f,indent=2)
        with open(dump_dir / "used_status_tiles.json","w") as f:
            tile_cluts_dict = {hex(k):[hex(x) for x in v] for k,v in status_tile_cluts.items() if v}
            json.dump(tile_cluts_dict,f,indent=2)

#add_tile(main_tile_cluts,0xA9,[4])   # force some tile
def add_tile(table,index,cluts=[0]):
    if isinstance(index,range):
        pass
    elif not isinstance(index,(list,tuple)):
        index = [index]
    for idx in index:
        table[idx].extend(cluts)

def write_status_addresses():
    # X/Y status address table
    address = 0x8040
    table = []
    for y in range(32):
        for x in range(4,8):
            table.append(address+x)
        for x in range(0,4):
            table.append(address+x)
        address += 0x20

    with (src_dir/"status_addresses.68k").open("w") as f:
        bitplanelib.dump_asm_bytes(table,f,mit_format=True,size=2)

def palette_pad(palette,pad_nb):
    palette += (pad_nb-len(palette)) * [(0x10,0x20,0x30)]



def load_tileset(image_name,palette_index,side,tileset_name,dumpdir,dump=False,name_dict=None,cluts=None,start_palette_index=0):

    if not image_name:
        # some cluts are blank, but we need to count them
        image_name = Image.new("RGB",(256,64))

    tiles_1 = image_name
    nb_rows = tiles_1.size[1] // side
    nb_cols = tiles_1.size[0] // side

    tileset_1 = []

    if dump:
        dump_subdir = os.path.join(dumpdir,tileset_name)
        if palette_index == start_palette_index:
            ensure_empty(dump_subdir)

    tile_number = 0
    palette = set()

    for j in range(nb_rows):
        for i in range(nb_cols):

            if cluts and palette_index not in cluts.get(tile_number,[]):
                # no clut declared for that tile
                tileset_1.append(None)
            else:
                img = Image.new("RGB",(side,side))
                img.paste(tiles_1,(-i*side,-j*side))

                # only consider colors of used tiles
                palette.update(set(bitplanelib.palette_extract(img)))


                tileset_1.append(img)
                if dump:
                    img = ImageOps.scale(img,5,resample=Image.Resampling.NEAREST)
                    if name_dict:
                        name = name_dict.get(tile_number,"unknown")
                    else:
                        name = "unknown"

                    img.save(os.path.join(dump_subdir,f"{name}_{tile_number:02x}_{palette_index:02x}.png"))

            tile_number += 1

    return sorted(set(palette)),tileset_1




def paint_black(img,coords):
    for x,y in coords:
        img.putpixel((x,y),(0,0,0))

def change_color(img,color1,color2):
    rval = Image.new("RGB",img.size)
    for x in range(img.size[0]):
        for y in range(img.size[1]):
            p = img.getpixel((x,y))
            if p==color1:
                p = color2
            rval.putpixel((x,y),p)
    return rval

def add_sprite(index,name,cluts=[0]):
    if isinstance(index,range):
        pass
    elif not isinstance(index,(list,tuple)):
        index = [index]
    for idx in index:
        sprite_names[idx] = name
        sprite_cluts[idx] = cluts

def save_palettes(filename,main_tile_palette,status_tile_palette,dump_it):
    with (src_dir/filename).open("w") as f:
        f.write("main_palette:\n")
        bitplanelib.palette_dump(main_tile_palette,f,bitplanelib.PALETTE_FORMAT_ASMGNU)
        f.write("status_palette:\n")
        bitplanelib.palette_dump(status_tile_palette,f,bitplanelib.PALETTE_FORMAT_ASMGNU)
    if dump_it:
        bitplanelib.palette_dump(main_tile_palette,dump_dir / "main_tile_palette_orig.png",pformat=bitplanelib.PALETTE_FORMAT_PNG)
        bitplanelib.palette_dump(status_tile_palette,dump_dir / "status_tile_palette_orig.png",pformat=bitplanelib.PALETTE_FORMAT_PNG)
        with (dump_dir/"main_colors.txt").open("w") as f:
            bitplanelib.palette_dump(main_tile_palette,f,bitplanelib.PALETTE_FORMAT_TEXT)
        with (dump_dir/"status_colors.txt").open("w") as f:
            bitplanelib.palette_dump(status_tile_palette,f,bitplanelib.PALETTE_FORMAT_TEXT)


def remove_colors(imgname):
    img = Image.open(imgname)
    for x in range(img.size[0]):
        for y in range(img.size[1]):
            c = img.getpixel((x,y))
            if c in colors_to_remove:
                img.putpixel((x,y),(0,0,0))
    return img

def add_hw_sprite(index,name,cluts=[0]):
    if isinstance(index,range):
        pass
    elif not isinstance(index,(list,tuple)):
        index = [index]
    for idx in index:
        sprite_names[idx] = name
        hw_sprite_cluts[idx].extend(cluts)


def dump_asm_bytes(*args,**kwargs):
    bitplanelib.dump_asm_bytes(*args,**kwargs,mit_format=True)



def ensure_empty(d):
    if os.path.exists(d):
        for f in os.listdir(d):
            x = os.path.join(d,f)
            if os.path.isfile(x):
                os.remove(x)
    else:
        os.makedirs(d)

def ensure_exists(d):
    if os.path.exists(d):
        pass
    else:
        os.makedirs(d)

sr2 = lambda a,b : set(range(a,b,2))

def get_sprite_names():
    rval = {}
    rval[0x38] = "game_over"
    rval[0x39] = "game_over"
    rval.update({i:"car" for i in range(0x3C,0x40)})
    return rval



plane_orientations = [("standard",lambda x:x),
("mirror",ImageOps.mirror),
("flip",ImageOps.flip),
("flip_mirror",lambda x:ImageOps.flip(ImageOps.mirror(x)))]


def apply_color_replacement(sprite_set_list,quantized):
    """ change colors for list of tilesets (tiles, sprites)
    quantized: RGB => RGB color replacement dictionary
    returns updated palette
    """
    rval = set()

    for sset in sprite_set_list:
        for tile in sset:
            if tile:
                bitplanelib.replace_color_from_dict(tile,quantized)
                rval.update(bitplanelib.palette_extract(tile))
    return sorted(rval)

def read_tileset(img_set_list,palette,plane_orientation_flags,cache,nb_planes,is_bob=False,is_hw_sprite=False,next_cache_id=1):

    if 1<<nb_planes != len(palette):
        raise Exception(f"palette has too many colors {len(palette)} vs nb planes {nb_planes}")
    tile_table = []

    for n,img_set in enumerate(img_set_list):
        tile_entry = []
        for i,tile in enumerate(img_set):
            entry = dict()
            if tile:

                for b,(plane_name,plane_func) in zip(plane_orientation_flags,plane_orientations):
                    if b:

                        actual_nb_planes = nb_planes
                        wtile = plane_func(tile)

                        if is_bob:
                            y_start,wtile = bitplanelib.autocrop_y(wtile)
                            height = wtile.size[1]
                            actual_nb_planes += 1
                            bitplane_data = bitplanelib.palette_image2raw(wtile,None,palette,generate_mask=True,blit_pad=False)
                        elif is_hw_sprite:
                            height = wtile.size[1]
                            bitplane_data = bitplanelib.palette_image2sprite(wtile,None,palette)
                        else:
                            height = 8
                            y_start = 0
                            # use a mask color which is not 0, 0,0,0 is a used color
                            bitplane_data = bitplanelib.palette_image2raw(wtile,None,palette,mask_color=(0x1,0x1,0x1))

                        if not is_hw_sprite:
                            plane_size = len(bitplane_data) // actual_nb_planes
                            bitplane_plane_ids = []
                            for j in range(actual_nb_planes):
                                offset = j*plane_size
                                bitplane = bitplane_data[offset:offset+plane_size]

                                cache_id = cache.get(bitplane)
                                if cache_id is not None:
                                    bitplane_plane_ids.append(cache_id)
                                else:
                                    if any(bitplane):
                                        cache[bitplane] = next_cache_id
                                        bitplane_plane_ids.append(next_cache_id)
                                        next_cache_id += 1
                                    else:
                                        bitplane_plane_ids.append(0)  # blank
                            entry[plane_name] = {"height":height,"y_start":y_start,"bitplanes":bitplane_plane_ids}
                        else:
                            entry[plane_name] = {"height":height,"y_start":0,"bitplanes":bitplane_data}

            tile_entry.append(entry)

        tile_table.append(tile_entry)

    nb_cluts = 8 if is_bob else NB_CLUTS
    new_tile_table = [[[] for _ in range(nb_cluts)] for _ in range(len(tile_table[0]))]

    # reorder/transpose. We have 16 * 256 we need 256 * 16
    for i,u in enumerate(tile_table):
        for j,v in enumerate(u):
            new_tile_table[j][i] = v

    return new_tile_table,next_cache_id

def write_tile_entries(f,prefix,tile_table):
    f.write(f"{prefix}_tile_table:\n")
    for i,tile_entry in enumerate(tile_table):
        f.write("\t.long\t")
        if any(tile_entry):
            f.write(f"{prefix}_tile_{i:02x}")
        else:
            f.write("0")
        f.write("\n")

    for i,tile_entry in enumerate(tile_table):
        if any(tile_entry):
            f.write(f"{prefix}_tile_{i:02x}:\n")
            for j,t in enumerate(tile_entry):
                f.write("\t.long\t")
                if t:
                    f.write(f"{prefix}_tile_{i:02x}_{j:02x}")
                else:
                    f.write("0")
                f.write("\n")


    for i,tile_entry in enumerate(tile_table):
        if tile_entry:
            for j,t in enumerate(tile_entry):
                if t:
                    name = f"{prefix}_tile_{i:02x}_{j:02x}"

                    f.write(f"{name}:\n")
                    for orientation,_ in plane_orientations:
                        f.write("* {}\n".format(orientation))
                        if orientation in t:
                            data = t[orientation]
                            for bitplane_id in data["bitplanes"]:
                                f.write("\t.long\t")
                                if bitplane_id:
                                    f.write(f"tile_plane_{bitplane_id:02d}")
                                else:
                                    f.write("0")
                                f.write("\n")
                            if len(t)==1:
                                # optim: only standard
                                break
                        else:
                            for _ in range(nb_planes):
                                f.write("\t.long\t0\n")

def save_graphics(filename,main_tile_table,status_tile_table,sprite_table,tile_plane_cache):
    with (src_dir/filename).open("w") as f:
        f.write("\t.global\tmain_tile_table\n")
        f.write("\t.global\tstatus_tile_table\n")
        f.write("\t.global\tsprite_table\n")

        write_tile_entries(f,"main",main_tile_table)
        write_tile_entries(f,"status",status_tile_table)



        for k,v in tile_plane_cache.items():
            f.write(f"tile_plane_{v:02d}:")
            dump_asm_bytes(k,f)

        f.write("sprite_table:\n")
        for i,tile_entry in enumerate(sprite_table):
            f.write("\t.long\t")
            if any(tile_entry):
                prefix = sprite_names.get(i,"bob")
                f.write(f"{prefix}_{i:02x}")
            else:
                f.write("0")
            f.write("\n")

        for i,tile_entry in enumerate(sprite_table):
            if any(tile_entry):
                prefix = sprite_names.get(i,"bob")
                f.write(f"{prefix}_{i:02x}:\n")
                for j in range(NB_TARGET_SPRITES):
                    f.write("\t.long\t")
                    f.write(f"{prefix}_{i:02x}_{j:02x}")

                    f.write("\n")


        for i,tile_entry in enumerate(sprite_table):
            if any(tile_entry):
                t = tile_entry[0]

                prefix = sprite_names.get(i,"bob")
                for j in range(NB_TARGET_SPRITES):
                    name = f"{prefix}_{i:02x}_{j:02x}"

                    f.write(f"{name}:\n")

                    for orientation,_ in plane_orientations:
                        f.write(f"\t.long\t{name}_{orientation}\n")
                        for bitplane_id in t[orientation]["bitplanes"]:
                                pass


        f.write("\n\t.section\t.datachip\n")

        for i,tile_entry in enumerate(sprite_table):
            if any(tile_entry):
                t = tile_entry[0]

                prefix = sprite_names.get(i,"bob")
                for j in range(NB_TARGET_SPRITES):
                    name = f"{prefix}_{i:02x}_{j:02x}"


                    for orientation,_ in plane_orientations:
                        f.write(f"{name}_{orientation}:\n")
                        bitplanelib.dump_asm_bytes(t[orientation]["bitplanes"],f,mit_format=True)

alphanum_tile_codes = set(range(0,10)) | set(range(65-48,65+27-48))

if __name__ == "__main__":
    raise Exception("no main!")