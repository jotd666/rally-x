# this tool uses the mame trace file (trace gyruss.tr) which is huge (because the whole game is played)
# it builds a dictionnary with all addresses that have been reached while playing

import re,json

tr_re = re.compile("(\w+): (.*)")

valid_addresses = dict()

with open("rallyx.tr") as f:
    for line in f:
        m = tr_re.match(line)
        if m:
            address = m.group(1)
            valid_addresses[address] = m.group(2)

with open("executed.json","w") as f:
    json.dump(valid_addresses,f,indent=2)
