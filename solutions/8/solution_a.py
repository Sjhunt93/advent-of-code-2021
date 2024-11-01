import re
#def is_1(code):

class Segment:
    """
     aaa
    b   c
    b   c
     ddd
    e   f
    e   f
     ggg
    """
    maps = {}

    def resolve_a(items):
        _1 = re.match("..")
        _7 = re.match("...")
        print(_1, " . ", _7)

c = 0

with open("text.txt") as f:
    lines = f.readlines()
    for l in lines:
        patterns, output = l.split("|")
        output = output[1:].replace("\n", "")
        
        #print(patterns, output)

        
        # segments = output.split(" ")
        
        # for s in segments:
            
        #     if len(s) in [2, 3, 4, 7]: 
        #         print(s, len(s))
        #         c += 1
        # print("\n")
print(c)