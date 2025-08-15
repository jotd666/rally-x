from shared import *
import bitplanelib

tilegen = gfx_dir / "tilegen"

def doit():
    cluts_file = tilegen / "cluts.txt"

    cluts = []
    current = []

    with open(cluts_file) as f:
        for line in f:
            if '#' in line:
                continue
            toks = line.split(",")
            if len(toks)==4:
                toks = tuple([int(x) for x in toks[0:3]])
                current.append(toks)
                if len(current)==4:
                    cluts.append(current)
                    current=[]
    return cluts

if __name__ == "__main__":
    cluts = doit()
    with open(source_dir / "amiga" / "cluts.68k","w") as f:
        f.write("cluts:\n")
        for clut in cluts:
            f.write("\t.word\t")
            f.write(",".join(hex(bitplanelib.to_rgb4_color(c)) for c in clut))
            f.write("\n")
