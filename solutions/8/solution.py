import re
#def is_1(code):

output_mapping = {
    "abcefg": 0,
    "cf": 1,
    "acdeg": 2,
    "acdfg" : 3,
    "bcdf" : 4,
    "abdfg" : 5,
    "abdefg": 6,
    "acf": 7,
    "abcdefg" : 8,
    "abcdfg" : 9
}

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
    # 6 segments lit = [0, 9, 6]
    # 5 segments list = [2,3,5]
    maps = {}

    def sub_set(list1, list2):
        print(list1, list2)
        if len(list1) >= len(list2):
            return [x for x in list1 if x not in list2]
        else:
            return [x for x in list2 if x not in list1]

    def sub_set_a_not_b(a, b):
        return [x for x in a if x not in b]
        
    #every element of 9 is in 4
    def find_9(items, _4):
        for i in items:
            if len(i) == 6:
                # since every element of 4 is in 9 this would return 2
                q = Segment.sub_set(i, _4)
                if len(q) == 2:
                    return i
        assert False

    #error
    def find_0(items, _4):
        for i in items:
            if len(i) == 6:
                # since every element of 0 is in 8 this would return 1
                q = Segment.sub_set(i, _4)
                if len(q) == 1:
                    return i
        assert False

    def find_2(items, _4):

        for i in items:
            if len(i) == 5:
                # the difference between 4 and 2,3,5 is either 2 or 1, a dif of 1 is 2.
                q = Segment.sub_set_a_not_b(_4, i)
                print(i, " In 2", q)
                if len(q) == 1:
                    return i
        assert False

    def find_3(items, segments_found_so_far):
        print("SEGMENTS", segments_found_so_far)
        for i in items:
            if len(i) == 5:
                # since every element of 0 is in 8 this would return 1
                q = Segment.sub_set(i, segments_found_so_far)
                print(q)
                if len(q) == 1:
                    return i
        assert False

    # we find numbers by set subtraction.
    # i.e. to find 2 (b) we use 4 (a), they would have a difference of 1 element (i.e. segment 4 has one lit element not in 2)
    def find_num_by_sub_traction(items, known_number, sub_length, flip_condition=False):
        print("Finding in ", items, " with known ", known_number)
        for i in items:
            if flip_condition:
                q = Segment.sub_set_a_not_b(i, known_number)
            else:
                q = Segment.sub_set_a_not_b(known_number, i)
            print("Difference", q)
            if len(q) == sub_length:
                return i
        assert False

    def resolve_7(full_string, items):

        Segment.maps = {}

        _1 = re.findall(r"\b\w\w\b", full_string)[0]
        _7 = re.findall(r"\b\w\w\w\b", full_string)[0]
        _4 = re.findall(r"\b\w\w\w\w\b", full_string)[0]
        _8 = re.findall(r"\b\w\w\w\w\w\w\w\b", full_string)[0]
        
        _5_segments_lit = re.findall(r"\b\w\w\w\w\w\b", full_string)
        _6_segments_lit = re.findall(r"\b\w\w\w\w\w\w\b", full_string)
        print("1:", _1, " 7: ", _7, ", ", _4, " ", _8, " ")

        print("5s", _5_segments_lit, " 6s", _6_segments_lit)

        #_9 = Segment.find_9(items, _4)
        print("FINDING 9")
        _9 = Segment.find_num_by_sub_traction(_6_segments_lit, _4, 0)
        _6_segments_lit.remove(_9)

        # we can resolve 3,5,6
        print("FINDING 2")
        _2 = Segment.find_num_by_sub_traction(_5_segments_lit, _4, 2)
        _5_segments_lit.remove(_2)
        print("FINDING 3")
        _3 = Segment.find_num_by_sub_traction(_5_segments_lit, _7, 0)
        _5_segments_lit.remove(_3)
        print("LEFT WITH 5")
        _5 = _5_segments_lit[0]

        # now just need to work out 0 and 6
        print("FINDING 0")
        _0 = Segment.find_num_by_sub_traction(_6_segments_lit, _7, 0)
        _6_segments_lit.remove(_0)

        assert len(_6_segments_lit) == 1
        print("LEFT WITH 6")

        _6 = _6_segments_lit[0]

        top = Segment.sub_set_a_not_b(_7, _1)
        assert(len(top) == 1)
        Segment.maps[top[0]] = "a"

        top_right = Segment.sub_set_a_not_b(_1, _6)
        assert(len(top_right) == 1)
        Segment.maps[top_right[0]] = "c"

        bottom_right = _1.replace(top_right[0], "")
        assert(len(bottom_right) == 1)
        Segment.maps[bottom_right[0]] = "f"

        mid = Segment.sub_set_a_not_b(_8, _0)
        assert(len(mid) == 1)
        Segment.maps[mid[0]] = "d"
        
        bot = Segment.sub_set_a_not_b(_3, ''.join(Segment.maps.keys()))
        assert(len(bot) == 1)
        Segment.maps[bot[0]] = "g"

        top_left = Segment.sub_set_a_not_b(_5, ''.join(Segment.maps.keys()))
        assert(len(top_left) == 1)
        Segment.maps[top_left[0]] = "b"

        bot_left = Segment.sub_set_a_not_b(_2, ''.join(Segment.maps.keys()))
        assert(len(bot_left) == 1)
        Segment.maps[bot_left[0]] = "e"


        return

        _0 = Segment.find_0(items, _8)
        #_3 = Segment.find_0(items, _8)
        #every element of 9 is in 4
        print("1:", _1, "2:", _2, " 7: ", _7, ", ", _4, " ", _8, " ", _9)
        # if _1 and _7:
        top = Segment.sub_set(_1, _7)
        mid = Segment.sub_set(_0, _8)

        assert(len(top) == 1)
        assert(len(mid) == 1)

        print("Top is", top)
        print("Mid is", mid)
        Segment.maps[top[0]] = "a"
        Segment.maps[mid[0]] = "d"

        s1 = _1[0]
        s2 = _1[1]
        print(s1, s2)
        seg_c = ''
        for i in items:
            # solve the right hand side
            # this is a bit crap but it either finds 2 or 6
            # if the top segment is in 2 we know that it becomes C
            # if the bottom segment is in 6 then that s2 if f
            if s1 in i and s2 not in i and len(i) == 6:
                seg_c = s2
                Segment.maps[s2] = "c"
                Segment.maps[s1] = "f"
                print(i, " is 2")
                break
            elif s2 in i and s1 not in i and len(i) == 6:
                seg_c = s1
                Segment.maps[s1] = "c"
                Segment.maps[s2] = "f"
                print(i, " is 2")
                break
        
        print(Segment.maps.keys())
        top_left = [x for x in _4 if x not in Segment.maps.keys()]

        #top_left = Segment.sub_set(_4, ''.join(Segment.maps.keys()))
        print(top_left)
        assert len(top_left) == 1

        _3 = Segment.find_3(items, ''.join(Segment.maps.keys()))

        bot = Segment.sub_set(_3, ''.join(Segment.maps.keys()))
        assert(len(bot) == 1)
        Segment.maps[bot[0]] = "g"



        

        # now we use 4 to solve left again
        top_left = [x for x in _4 if x not in Segment.maps.keys()]
        print(top_left)
        assert len(top_left) == 1
        Segment.maps[top_left[0]] = "b"
        for seg in items:
            if len(seg) == 6:
                bottom = [x for x in seg if x not in Segment.maps.keys()]
                # will give us 9
                
                if len(bottom) == 1:
                    print("MATCH", bottom,  seg, Segment.maps.keys())    
                    Segment.maps[bottom[0]] = "g"
                    break

        bottom_left = [x for x in _8 if x not in Segment.maps.keys()]
        print(bottom_left)
        Segment.maps[bottom_left[0]] = 'e'

        assert(len(Segment.maps.keys() == 7))

    # def resolve_7(full_string, items):
    #     _1 = re.findall(r"\b\w\w\b", full_string)[0]
    #     _7 = re.findall(r"\b\w\w\w\b", full_string)[0]
    #     _4 = re.findall(r"\b\w\w\w\w\b", full_string)[0]
    #     _8 = re.findall(r"\b\w\w\w\w\w\w\w\b", full_string)[0]
    #     #every element of 9 is in 4
    #     print(_1, " , ", _7, ", ", _4, " ", _8)
    #     # if _1 and _7:
    #     top = [x for x in _7 if x not in _1]
    #     mid = [x for x in _4 if x not in _8]

    #     print("Top is", top)
    #     print("Mid is", mid)
    #     Segment.maps[top[0]] = "a"
    #     Segment.maps[mid[0]] = "d"

    #     s1 = _1[0]
    #     s2 = _1[1]
    #     print(s1, s2)
    #     seg_c = ''
    #     for i in items:
    #         # solve the right hand side
    #         if s1 in i and s2 not in i and len(i) == 6:
    #             seg_c = s2
    #             Segment.maps[s2] = "c"
    #             Segment.maps[s1] = "f"
    #             print(i, " is 2")
    #             break
    #         elif s2 in i and s1 not in i and len(i) == 6:
    #             seg_c = s1
    #             Segment.maps[s1] = "c"
    #             Segment.maps[s2] = "f"
    #             print(i, " is 2")
    #             break

    #     # now we use 4 to solve left again
    #     top_left = [x for x in _4 if x not in Segment.maps.keys()]
    #     Segment.maps[top_left[0]] = "b"
    #     for seg in items:
    #         if len(seg) == 6:
    #             bottom = [x for x in seg if x not in Segment.maps.keys()]
    #             # will give us 9
                
    #             if len(bottom) == 1:
    #                 print("MATCH", bottom,  seg, Segment.maps.keys())    
    #                 Segment.maps[bottom[0]] = "g"
    #                 break

    #     bottom_left = [x for x in _8 if x not in Segment.maps.keys()]
    #     print(bottom_left)
    #     Segment.maps[bottom_left[0]] = 'e'

                    

    def resolve_0(items):
        _8 = re.findall(r"\b\w\w\w\w\w\w\w\w\b", items)[0]
        _0 = re.findall(r"\b\w\w\w\w\w\w\w\b", items)[0]
        middle = [x for x in _8 if x not in _0]
        Segment.maps[middle[0]] = "d"

c = 0

with open("text.txt") as f:
    lines = f.readlines()
    for l in lines:
        patterns, output = l.split("|")
        output = output[1:].replace("\n", "")
        print(patterns, " ** ", output)
        Segment.resolve_7(patterns, patterns.split(" "))
        #Segment.resolve_0(patterns)
        
        

        print(Segment.maps)
        segments = output.split(" ")
        all_segs = ""
        for out in segments:
            # last bit is needed here to map one to the other
            out = [Segment.maps[i] for i in out ]
            k = ''.join(sorted(out))
            print(k)
            all_segs += str(output_mapping[k])

        print(all_segs)
        c+= int(all_segs)
        Segment.maps = {}
        # segments = output.split(" ")
        
        # for s in segments:
            
        #     if len(s) in [2, 3, 4, 7]: 
        #         print(s, len(s))
        #         c += 1
        # print("\n")
print(c)