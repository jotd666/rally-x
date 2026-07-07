import re,pathlib

gamename = "rallyx"

# game_specific: replace or remove I/O addresses
# if not done it will write in ROM here!!
input_dict = {
"watchdog_a080":["","read_p2_inputs"],
"scrollx_a130":"set_scroll_x",
"scrolly_a140":"set_scroll_y",
"dsw_a100":"read_dsw",
"p1_a000":"read_p1_inputs",
}

single_line_to_cc_protect = {0X168d,0x15c4,0x0139,0x18c,0x031d,0x040a,0x0412,0x41a,0X0443,0x0477,0x04d5,0x0564,0X0b52,0x0b5e,0x0bbb,0x0bd3,0x1420,
0x0c1d,0x0c9e,0x0caa,0x0d98,0x0dc5,0x3e12,0x3e1a,0x1521,0x198d,0xBFF,0x15bf,0x1c05,0x1c0f}
remove_error_in_next_line = {0x2440,0x15c5,0x15c0,0x13C,0x018d,0X31F,0x03fd,0x040c,0x414,0x41C,0x0445,0x0478,0x04d7,0x0565,0x0b53,0x0b5f,0xB12,0x0c9f,0x0cab,0x0d99,
0x0646,0x0793,0x0441,0x04d3,0x0dc6,0x0dc3,0x0ef3,0x1421,0x141e,0x3e14,0x3e1c,0x1690,0x183a,0x1aef,0x1c06,0x1c10,
0x0c02,0x0bbc,0x0bd4,0x0c1e,0x1522,0x17b8,0x198e,0x3A23}
remove_error_in_prev_line = {0x3,0x0b1e,0x0b22,0x3800,0x389e,0x06ab,0x0a7a,0x39ce,0x39cf,0x39d0,0x39d1,0x39ef,0x39f0,0x39f1,0x39f2}
line_to_push_cc_protect = {0x0eed,0x3a1e} | single_line_to_cc_protect
line_to_pull_cc_protect = {0x0ef2,0x3a21} | single_line_to_cc_protect


store_to_video = re.compile("GET_ADDRESS\s+(0x8\w\w\w|video_ram_d)",flags=re.I)   # game_specific


# post-conversion automatic patches, allowing not to change the asm file by hand
tablere = re.compile("move.w\t#(\w*table_....),d(.)")
jmpre = re.compile("(j..)\s+\[a,(.)\]")
dreg_dict = {'a':'d0','b':'d1'}
areg_dict = {'x':'a2','y':'a3','u':'a4'}



def remove_continuing_lines(lines,i):
    for j in range(i+1,i+4):
        if "[...]" in lines[j]:
            lines[j] = ""
        else:
            break


def get_line_address(line):
    try:
        toks = line.split("|")
        address = toks[1].strip(" [$").split(":")[0]
        return int(address,16)
    except (ValueError,IndexError):
        return None

def remove_continuing_lines(lines,i):
    for j in range(i+1,i+4):
        if "[...]" in lines[j]:
            lines[j] = ""
        else:
            break


def change_instruction(code,lines,i,continuing_lines=True):
    line = lines[i]
    toks = line.split("|")
    if len(toks)==2:
        toks[0] = f"\t{code}"
        if continuing_lines:
            remove_continuing_lines(lines,i)
        return " | ".join(toks)
    return line

def remove_error(line,ignore=False):
    if "ERROR" in line:
        return ""
    elif not ignore:
        raise Exception(f"No ERROR to remove in {line}")
    else:
        return line
def remove_instruction(lines,i,continuing_lines=True):
    return change_instruction("",lines,i,continuing_lines=continuing_lines)

def remove_continuing_lines(lines,i):
    for j in range(i+1,i+4):
        if "[...]" in lines[j]:
            lines[j] = ""
        else:
            break



def process_jump_table(line):

    m = re.search("\[nb_entries=(\d+)",line)
    if m:
        nb_entries = m.group(1)
        line = f"""\t.ifndef\tRELEASE
\tmove.w\t#{nb_entries},d7
\t.endif
"""+line

    return line

def get_original_instruction(line):
    toks = line.split("| [")
    if len(toks)==1:
        return ""
    inst = toks[1][7:].split("]")[0]
    return inst


def remove_code(pattern,lines,i):
    if pattern in lines[i]:
        lines[i] = remove_instruction(lines,i)
        remove_continuing_lines(lines,i)
    return lines[i]

def rebuild_lines(lines):
    return "".join(lines).splitlines(True)

def swap_lines(lines,i,j):
    lines[i],lines[j] = lines[j].rstrip()+ "| swapped\n",lines[i].rstrip()+ "| swapped\n"
    return lines[i]

def kill_code(lines,start_line,end_address):
    while True:
        address = get_line_address(lines[start_line])
        lines[start_line] = remove_instruction(lines,start_line)
        if "|" not in lines[start_line]:
            lines[start_line] = ""
        if address == end_address:
            break
        start_line+=1

def subt(m):
    tn = m.group(1)
    rn = m.group(2)
    offset = tn.split("_")[-1]
    rval = f"""
\t.ifndef\tRELEASE
\tmove.w\t#0x{offset},d{rn}
\t.endif
\tlea\t{tn},a{rn}"""
    return rval

equates = []
global_symbols = []
equates_re = re.compile("(\w+)\s*=\s*(\$?\w+)")
this_dir = pathlib.Path(__file__).absolute().parent

source_dir = this_dir / "../src"

# various dirty but at least automatic patches applying on the converted code
with open(source_dir / "conv.s") as f:
    lines = list(f)

    for i,line in enumerate(lines):
        m = equates_re.match(line)
        if m:
            equates.append(line)
            line = ""


##        elif "review stray daa" in line:
##            line = """\tCLR_XC_FLAGS
##\tmove.b\t(a0),d6
##\tabcd\td6,d0
##"""
        address = get_line_address(line)

        if "[address_pop]" in line:
            if "MAKE_" in line:
                line = ""
            else:
                line = change_instruction("addq.w\t#4,sp",lines,i)

        elif "[return]" in line:
            if "MAKE_" in line:
                line = ""
            else:
                line = change_instruction("rts",lines,i)

        elif "[nop]" in line:
            line = remove_instruction(lines,i)

        elif "[breakpoint]" in line and address:
            line = f'\tBREAKPOINT "{address:04x}"\n{line}'

        elif "[cc_ok]" in line:
            if "rts" in line and "ret]" not in line: # conditional return
                lines[i-1] = remove_error(lines[i-1],True)
            else:
                lines[i+1] = remove_error(lines[i+1],True)


        line = process_jump_table(line)

        if "[push_function]" in line:
            toks = line.split()
            line = remove_instruction(lines,i)
            pa = toks[1].strip("#")
            lines[i+1] = change_instruction(f"pea\t{pa}",lines,i+1)

        # pre-add video_address tag if we find a store instruction to an explicit 3000-3FFF address
        m = store_to_video.search(line)
        if m:
            g = m.group(1)
            okay = True
            if g.startswith("0x"):
                target_address = int(g,16)  # not used
                if "ix," not in line and "iy," not in line:
                    line = line.rstrip() + " [video_address]\n"

        if "[video_address" in line or "[unchecked_address" in line:
            if (",a2" in line or ",a3" in line) and "GET_ADDRESS" not in line:
                    # using indexed ix/iy: parse code to insert the proper dirty macro
                    toks = line.split()
                    toks = toks[1].split(",")
                    destreg = toks[2].strip("()")
                    destz = "IX" if destreg=="a2" else "IY"
                    offset = toks[1].strip("()")
                    line += f"\tVIDEO_BYTE_DIRTY_{destz}\t{offset}\n"
            else:
                # give me the original instruction
                line = line.replace("_ADDRESS","_UNCHECKED_ADDRESS")
                if "MAKE" in line:
                    line = re.sub(r"(MAKE_AR)",r"\1_UNCHECKED",line)
                    line = re.sub(r"(MAKE_[HDB]\w)",r"\1_UNCHECKED",line)
                elif "MAKE" in lines[i-1] and "UNCHECKED" not in lines[i-1]:
                    lines[i-1] = re.sub(r"(MAKE_AR)",r"\1_UNCHECKED",lines[i-1])
                    lines[i-1] = re.sub(r"(MAKE_[HDB]\w)",r"\1_UNCHECKED",lines[i-1])

                if "ldir" in line:
                    line = line.replace("ldir","ldir_video" if "[video_address" in line else "ldir_unchecked")
                elif "[video_address" in line:
                    if ",(a0)" in line or ("(a0)" in line and "clr.b" in line):
                        line += "\tVIDEO_BYTE_DIRTY | [...]\n"
                    elif (",(a0)" in lines[i+1] or ("(a0)" in  lines[i+1]  and "clr.b" in lines[i+1] )):
                        lines[i+1]  += "\tVIDEO_BYTE_DIRTY | [...]\n"
        if "[pop_stack]" in line:
            line = change_instruction("addq\t#4,sp",lines,i)

        line = re.sub("#(i[xy][hl])",r"\1",line)

        ###############################################
        # game_specific

        if "replace by EXG_A_A_PRIME" in line:
            #lines[i-1] = "* just swap A/A'\n"+change_instruction("EXG_A_A_PRIME",lines,i-1)
            line = remove_error(line)
        if "review stray cmp before MAKE_HL_NO_AR" in line:
            # remove the errors now that the result is CC protected
            line = remove_error(line)

        if "unsupported instruction im" in line:
            line = remove_error(line)
        if "unsupported instruction out" in line:
            line = remove_error(line)

        if address == 0x0003:
            line = remove_instruction(lines,i)
        elif address in {0x3FD,0x0b12}:
            line = "\ttst.b\td0\n"+line
        elif address in {0x0644,0x1837}:
            line = swap_lines(lines,i,i-1)
        elif address == 0x078E:
            lines[i+1] = remove_error(lines[i+1])
        elif address == 0x05dc:
            line = change_instruction("jbsr\tosd_get_random",lines,i)
        elif address == 0x790:
            line = swap_lines(lines,i,i-2)
        elif address in {0x3800,0x06ab,0x0a7a,0x389e}:  # stack shit
            line = remove_instruction(lines,i)
        elif address in {0x39ce,0x39cf,0x39d0,0x39d1,0x39ef,0x39f0,0x39f1,0x39f2}:  # stack shit
            line = change_instruction("ILLEGAL",lines,i)
        elif address in {0x0f61}:
            # cmp+error+pop bc rewrite
            lines[i+1] = remove_error(lines[i+1])
            lines[i+2] = lines[i+2].replace("move.w","movem.w") + "\tPUSH_SR\n"
            lines[i+3] += "\tPOP_SR\n"
            lines[i+5] = remove_error(lines[i+5])
        elif address in {0x1206,0x121b,0x1227}:
            # jsr+pop bc rewrite
            line = line.replace("move.w","movem.w") + "\tPUSH_SR\n"
            lines[i+1] += "\tPOP_SR\n"
            lines[i+3] = remove_error(lines[i+3])
        elif address == 0x17b6:
            line = swap_lines(lines,i,i-2)
        elif address == 0x023A:
            # push de+pop iy okay but then push de (and pop iy later)
            # replace by push iy
            line = change_instruction("move.l\ta3,-(a7)",lines,i)
        elif address == 0x0d55:
            line += "\tSET_X_FROM_C\n"  # make flag more persistent
        elif address == 0x0d59:
            line = "\tSET_C_FROM_X\n"+line  # retrieve X into C
        elif address == 0x09A7:
            # of course Namco coders can't help use ixl crap
            line = """
* replace ixh code shit altogether
\tmove.l\ta2,d7
\tsub.l\ta6,d7
\tadd.b\t#2,d7
\tand.b\t#0xF7,d7
\tadd.l\ta6,d7
\tmove.l\td7,a2
"""
            kill_code(lines,i+1,0x09ad)
        elif address == 0x1311:
            # try to preserve X flag
            # first use dbf
            line += "\tand.w\t#0xFF,d1\n\tsubq.w\t#1,d1\n"
        elif address == 0x1312:
            line += "\tSET_X_FROM_C\n"   # save C into X, will resist the end of routine
        elif address == 0x1313:
            line = change_instruction("dbf\td1,l_1312",lines,i)
        elif address == 0x1318:
            line = "\tSET_C_FROM_X\n"+line  # put X into C to respect function interface
        # end game_specific
        ###############################################
        if address in remove_error_in_prev_line:
            lines[i-1] = remove_error(lines[i-1].strip()+f" ({address:04x})")
        if address in remove_error_in_next_line:
            lines[i+1] = remove_error(lines[i+1].strip()+f" ({address:04x})")
        if address in line_to_pull_cc_protect:
            # protect the sub instructions if any
            for j in range(i+1,len(lines)):
                if not "[...]" in lines[j]:
                    break

            lines[j-1] += "\tPOP_SR\n"
            if j-1==i:
                line = lines[i]

        if address in line_to_push_cc_protect:
            # protect the sub instructions
            line = "\tPUSH_SR\n"+line

        if "GET_ADDRESS" in line:
            val = line.split()[1].split(",")[0]
            osd_call = input_dict.get(val)
            if osd_call is not None:

                if osd_call:
                    if isinstance(osd_call,list):
                        # choose depending on read/write
                        if "a,(" in line:
                            osd_call = osd_call[1]
                        else:
                            osd_call = osd_call[0]
                    if osd_call:
                        line = change_instruction(f"jbsr\tosd_{osd_call}",lines,i)
                    else:
                        line = remove_instruction(lines,i)
                else:
                    line = remove_instruction(lines,i)
                lines[i+1] = remove_instruction(lines,i+1)

        if "[global]" in line:
            label = line.split(":")[0]
            global_symbols.append(label)

        lines[i] = line

    # remove duplicate VIDEO_BYTE_DIRTY
    lines = rebuild_lines(lines)
    new_lines = []
    prev_line = ""
    for line in lines:
        if "VIDEO_BYTE_DIRTY" in line and "VIDEO_BYTE_DIRTY" in prev_line:
            pass
        else:
            new_lines.append(line)
        prev_line = line

with open(source_dir / "data.inc","w") as fw:
    fw.writelines(equates)

with open(source_dir / f"{gamename}.68k","w") as fw:

    fw.write(f"""\t.include "data.inc"
""")
    for g in global_symbols:
        fw.write(f"\t.global\t{g}\n")

    fw.writelines(new_lines)
