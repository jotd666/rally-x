# this tool reads the executed json file (from the other script) and rebuilds the
# Z80 code, avoiding the fake code (unexecuted). If it stumbles on an unterminated sequence,
# it can fill with unexecuted code

import re,json,bisect

tr_re = re.compile("(\w+): (.{12})(.*)")

code = dict()
with open("rallyx_z80_full.asm") as f:
    for line in f:
        m = tr_re.match(line)
        if m:
            address,hexs,instruction = m.groups()
            code[address] = (hexs,instruction)

with open("executed.json") as f:
    executed = json.load(f)

out = dict()

for k,v in executed.items():
    if k in code:
        out[k] = code[k]
    else:
        out[k] = ("?"*11+" ",v)

# sorted so we can bisect
bisectable_addresses = sorted(code)

end_of_sequence = False
first_inst = True

def is_end_of_sequence(toks):
    end_of_sequence = False
    if toks[0] in ["jp","jr","ret","rst"]:
        if toks[0]=="ret":
            if len(toks)==1:
                end_of_sequence = True
        elif toks[0] == "rst":  # rst 30 is a jumper
            if toks[1]=="$30":
                end_of_sequence = True
        else:
            if "," not in toks[1]:
                end_of_sequence = True
    return end_of_sequence

with open("rallyx_z80.asm","w") as f:
    for address,(hexs,instruction) in sorted(out.items()):
        toks = instruction.split()
        if not first_inst:
            # just had a end of sequence
            old_address = int(prev[0],16)
            new_address = int(address,16)
            old_size = len(prev[1][0].split())
            if not end_of_sequence and new_address != old_address+old_size:
                #f.write(f"; partial sequence coverage loss {old_address:04X} => {new_address:04x} ({old_size:X})\n")
                # find the instructions in the unfiltered file
                pos1 = bisect.bisect(bisectable_addresses,prev[0])
                pos2 = bisect.bisect(bisectable_addresses,address)
                for i in range(pos1,pos2-1):
                    uncov_address = bisectable_addresses[i]
                    old_hexs,instr = code[uncov_address]
                    f.write(f"{uncov_address}: {old_hexs}{instr}    ; [uncovered] \n")
                    if is_end_of_sequence(instr.split()):
                        f.write("\n")
                        break

        f.write(f"{address}: {hexs}{instruction}\n")
        end_of_sequence = is_end_of_sequence(toks)


        prev = address,(hexs,instruction)
        first_inst = False
        if end_of_sequence:
            # extra linefeed after unconditionnal ret or jump
            f.write("\n")

