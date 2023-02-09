with open("input.txt") as f:
    content = f.read()
    code, mappings = content.split("\n\n")
    template = {}
    alphabet = set()
    for mapping in mappings.split("\n"):
        print(mapping)
        input, output = mapping.split("->")
        template[input.strip()] = output.strip()
        alphabet.add(output.strip())
    
    # print(alphabet)
    # exit()    
    itrs = 40

    while itrs > 0:
        print(itrs)
        output = ""
        for i in range(0, len(code)-1):
            c = code[i:i+2]
            if c in template:
                output += c[0] + template[c]# + c[1]
                if i == len(code)-2: # edge case
                    output += c[1]
            else:
                output += c
        
        code = output
        itrs -=1
    
        counts = {}
        for c in code:
            if c not in counts:
                counts[c] = 1
            else:
                counts[c] += 1
        
        print(counts, len(counts.values()))
    # mx = max([x for x in counts.values()])
    # mn = min([x for x in counts.values()])
    # print(mx-mn)