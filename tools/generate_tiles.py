# pre-process for tiles, as I generally use the tile sheets that mame gfx save
# dumps. Here there are 64 cluts, and the gfx save features only saves 32 sheets
# so we have to rebuild them. It's not very difficult when the palette is properly dumped
import glob,shutil,os,re,pathlib
from PIL import Image
from shared import *

import gen_cluts

tilegen = gfx_dir / "tilegen"

pal4_file = tilegen / "pal_04.png"

cluts = gen_cluts.doit()

source = Image.open(pal4_file)
# this reference clut has all 4 colors different. We can use that to generate
# the other cluts (mame gfx save only saves up to 32 cluts, we need 64)
ref_clut = cluts[4]
for i in range(0,64):
    this_clut = cluts[i]
    if len(set(this_clut))>1:
        dest = Image.new("RGB",source.size)
        rep_dict = {k:v for k,v in zip(ref_clut,this_clut)}

        dest_file = gfx_dir / "tiles" / f"pal_{i:02x}.png"
        if i==4:
            shutil.copy(pal4_file,dest_file)
        else:
            for x in range(source.size[0]):
                for y in range(source.size[1]):
                    pix = source.getpixel((x,y))
                    newpix = rep_dict[pix]
                    dest.putpixel((x,y),newpix)
            dest.save(dest_file)