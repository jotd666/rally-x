import os,pathlib,shutil,json,itertools

from shared import *




def merge(used_name,nb_items,nb_cluts):
    merged_path_file = used_graphics_dir


    # merge sprites with existing file + moves from level 1
    used_dump = data_dir / used_name
    with open(used_dump,"rb") as f:
        new_contents = f.read()


    old_used = merged_path_file / used_name
    if old_used.exists():
        with open(old_used,"rb") as f:
            old_contents = f.read()
    else:
        old_contents = bytes(nb_cluts*nb_items)

    contents = bytes([a|b for a,b in itertools.zip_longest(new_contents,old_contents,fillvalue=0)])

    if old_contents == contents:
        print(f"Nothing new for {used_name}")
    else:
        for i,(a,b) in enumerate(itertools.zip_longest(old_contents,contents,fillvalue=0)):
            if a!=b:
                code,clut = divmod(i,nb_cluts)
                print(f"{used_name}: New: code={code:02x}, clut={clut:02x}")
        with open(merged_path_file / used_name,"wb") as f:
            f.write(contents)

#merge("used_sprites",256)
merge("used_main_tiles",256,64)
merge("used_status_tiles",256,64)
