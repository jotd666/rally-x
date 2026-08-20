from PIL import Image,ImageOps
import os,sys,bitplanelib,pathlib,json,collections


from shared import *
dump_it = True

def doit(aga,dump_it):
    if dump_it:
        if not os.path.exists(dump_dir):
            os.mkdir(dump_dir)
            with open(dump_dir / ".gitignore","w") as f:
                f.write("*")


    read_used_tiles(dump_it)

    nb_planes = 4 if aga else 3
    nb_colors = 1<<nb_planes



    sprite_sheet_dict = {i:Image.open(os.path.join(sheets_path / "sprites" / f"pal_{i:02x}.png")) for i in [0xB]}
    tile_sheet_dict = {i:imgopen(i) for i in range(NB_CLUTS)}


    main_tile_palette = set()
    main_tile_set_list = []

    for i,tsd in sorted(tile_sheet_dict.items()):
        tp,tile_set = load_tileset(tsd,i,8,"main_tiles",dump_dir,dump=dump_it,name_dict=None,cluts=main_tile_cluts)
        main_tile_set_list.append(tile_set)
        main_tile_palette.update(tp)

    status_tile_palette = set()
    status_tile_set_list = []

    for i,tsd in sorted(tile_sheet_dict.items()):
        tp,tile_set = load_tileset(tsd,i,8,"status_tiles",dump_dir,dump=dump_it,name_dict=None,cluts=status_tile_cluts)
        status_tile_set_list.append(tile_set)
        status_tile_palette.update(tp)

    sprite_palette = set()
    sprite_set_list = []
    hw_sprite_set_list = []


    # for HW sprites just read 1 sprite sheet, as long as all 4 (3) colors are distinct
    _,hw_sprite_set = load_tileset(sprite_sheet_dict[0xB],0xB,16,"hw_sprites",dump_dir,dump=dump_it,name_dict=sprite_names,cluts=hw_sprite_cluts,start_palette_index=0xB)


    if not aga:
        # we have to reduce colors for both main & status parts
        to_remove = [(0, 104, 0),(33, 71, 222),(71, 104, 71),(104, 0, 0),(151, 151, 151),(184, 71, 0),(222, 151, 71)]
        color_replacement_dict = {t:black for t in to_remove}    # those colors aren't really used
        color_replacement_dict[(255, 255, 151)] = (255, 255, 0)  # merge yellows
        status_tile_palette = apply_color_replacement(status_tile_set_list,color_replacement_dict)


        color_replacement_dict = {
(255, 255, 151):(255, 255, 0),  # merge yellows
(151, 151, 151) : (222, 222, 222),  # gray => whiter
(104, 0, 0) : (184, 71, 0),  # merge browns
(0, 104, 0) : (71, 104, 71),  # merge greens
(33, 222, 222) : black  # remove cyan
}
        main_tile_palette = apply_color_replacement(main_tile_set_list,color_replacement_dict)

    # orange in first position
    main_tile_palette = sorted(main_tile_palette)
    main_tile_palette.remove(orange)
    main_tile_palette = [orange]+main_tile_palette
    print(len(main_tile_palette))
    # black in any position but first, which is ignored
    status_tile_palette = sorted(status_tile_palette)
    status_tile_palette.insert(0,(0x1,0x1,0x1))  # dummy

    suffix = "aga" if aga else "ecs"


    sprite_table = [None]*NB_SPRITES



    tile_plane_cache = {}

    # pad if needed
    main_tile_palette += [(0X10,0x20,0x30)]*(nb_colors-len(main_tile_palette))
    status_tile_palette += [(0X10,0x20,0x30)]*(nb_colors-len(status_tile_palette))

    save_palettes(f"palette_{suffix}.68k",main_tile_palette,status_tile_palette,dump_it=dump_it)

    main_tile_table,next_cache_id = read_tileset(main_tile_set_list,main_tile_palette,[True,False,False,False],cache=tile_plane_cache,nb_planes=nb_planes)
    status_tile_table,_ = read_tileset(status_tile_set_list,status_tile_palette,[True,False,False,False],cache=tile_plane_cache,nb_planes=nb_planes,next_cache_id=next_cache_id)

    # no blitter objects here, only hardware sprites, I love old Namco hardware, almost matches amiga sprite specs (except for separate palettes!)
    sprite_table,_ = read_tileset([hw_sprite_set],sprite_clut_b,[True,True,True,True],cache=None,is_hw_sprite=True,nb_planes=2)


    save_graphics(f"graphics_{suffix}.68k",main_tile_table,status_tile_table,sprite_table,tile_plane_cache)

write_status_addresses()
doit(aga=True,dump_it=dump_it)
doit(aga=False,dump_it=False)
