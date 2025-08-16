import bitplanelib
import os,pathlib


this_dir = pathlib.Path(os.path.abspath(__file__)).parent
src_dir = this_dir / os.pardir / "src" / "amiga"

# http://amiga-dev.wikidot.com/hardware:bplcon1


# table with fine shift + byte offset
def doit(width,status_static_shift):
    asm_output = src_dir / f"scroll_table_{width}.68k"
    wmask = width-1

    items = []
    for x in range(0,512):
        shift = (wmask-(x & wmask))
        offset = (x // width)*(width//8)
        # pre-encode shift for bplcon

        shiftval_msb = ((shift&(wmask & 0x30))>>2)      # 2 high bits H7 H6
        items.append( (shiftval_msb<<4)) # put same shift for both "playfields"
        shiftval_lsb = (shift&0xF)                      # 4 low bits H5->H2
        items.append( (status_static_shift | shiftval_lsb<<4))

        items.append(0)
        items.append(offset)

    if asm_output:
        with open(asm_output,"w") as f:
            bitplanelib.dump_asm_bytes(bytes(items),f,True)
    return items

if __name__ == "__main__":
    doit(width = 16,status_static_shift = 3)   # FMODE=1

