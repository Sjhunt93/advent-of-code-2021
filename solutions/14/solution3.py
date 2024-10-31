from collections import defaultdict

with open("14/1/input.txt") as f:
    content = f.read()
    code, mappings = content.split("\n\n")
    template = {}
    alphabet = set()
    for mapping in mappings.split("\n"):
        print(mapping)
        input, output = mapping.split("->")
        template[input.strip()] = output.strip()
        alphabet.add(output.strip())
    
    
    inputs = defaultdict(int)
    for i in range(0, len(code)-1):
        inputs[code[i:i+2]] += 1
    
    itrs = 0

    while itrs < 40:
        outputs = defaultdict(int)
        for polymer, count in inputs.items():            
            a = polymer[0] + template[polymer]
            b = template[polymer] + polymer[1]
            outputs[a] += count
            outputs[b] += count
        
        itrs += 1
        inputs = outputs
    
    counts = defaultdict(int)
    for polymer, count in inputs.items():
        counts[polymer[0]] += count
    
    print(inputs)
    print(counts)
    # ends with is needed here for edge case
    r = [count+1 if code.endswith(polymer) else count for polymer, count in counts.items()]
    print(max(r) - min(r))