import re

def debug_print(points):
    x, y = get_size(points)
    data = [ ["." for _ in range(0, x)]  for i in range(0,y)]
    for p in points:
        x, y = p
        data[y][x] = "#"
    
    for d in data:
        print(''.join(d))
 

def get_size(points):

    x = max([p[0] for p in points])+1
    y = max([p[1] for p in points])+1
    return x, y

def create_partion(points, x, y):
    return set([p for p in points if p[0] < x and p[1] < y])

def vertical_fold(yfold, points):
    x, y = get_size(points)
    print(x, y)
    keep = create_partion(points, x, yfold+1)
    remove = points - keep
    print("Keeping", keep)
    print("removing", remove)
    for r in remove:
        xi, yi = r
        d = yi - (yfold)
        yi = (yfold) - d
        keep.add((xi, yi)) 
    return keep

def horizontal_fold(xfold, points):
    x, y = get_size(points)
    
    keep = create_partion(points, xfold+1, y)
    remove = points - keep
    print("Keeping", keep)
    print("removing", remove)
    for r in remove:
        xi, yi = r
        d = xi - (xfold)
        xi = (xfold) - d
        keep.add((xi, yi)) 
    return keep


with open("12/data.txt") as f:
    points, folds = f.read().split("\n\n")
    coordiantes = set()

    for p in points.split("\n"):
        coordiantes.add(tuple([int(i) for i in p.split(",")]))

    print(coordiantes)
    #debug_print(coordiantes)
    x, y = get_size(coordiantes)
    for f in folds.split("\n"):
        r = re.findall(".=\d+", f)[0]
        print(r, "\n\n")
        t, val = r.split("=")
        if t == 'x':
            x = int(val)-1
            coordiantes = horizontal_fold(int(val), coordiantes)
        else:
            coordiantes = vertical_fold(int(val), coordiantes)
            y = int(val)-1
        
        
    debug_print(coordiantes)
    print(len(coordiantes))
    
    #print(x*y - len(coordiantes))
    #print(x, y)