
import heapq

moves = {
    "^" : [0, -1],
    "v" : [0, 1],
    "<" : [-1, 0],
    ">" : [1, 0]
}
opposite = {"<": ">", ">": "<", "v": "^", "^": "v"}


def astartv2(maze, start, end):
    start = (0,0)
    end = (len(maze[0])-1, len(maze)-1)

    to_visit = [(0, start)]
    visited = set()
    results = []
    while to_visit:
        current_lava, current_pos = heapq.heappop(to_visit)
        if current_pos in visited:
            continue

        if current_pos == end:
            results.append(current_lava)

        visited.add(current_pos)
        for d, move in moves.items():
            x = current_pos[0] + move[0]
            y = current_pos[1] + move[1]
            new_pos = (x, y)
            # out of bounds
            if x < 0 or x >= len(maze[0]) or y < 0 or y >= len(maze):
                continue

            
            if new_pos in visited:
                continue
            lava = int(maze[y][x])
            
            heapq.heappush(to_visit, (current_lava + lava, new_pos))
        print(len(to_visit))
    return results




def to_matrix(lines):
    items = []
    for l in lines:
        #print(l)
        items.append([int(i) for i in l])
    return items

with open("15/data.txt") as f:

    lines = f.read().split("\n")
    matrix = to_matrix(lines)

    start = (0, 0)
    end = (len(matrix[0])-1, len(matrix)-1)
    p1 = astartv2(matrix, start, end)
    
    XSIZE = len(matrix[0])
    YSIZE = len(matrix)
    massive_grid = []
    for y in range(YSIZE*5):
        massive_grid.append([0 for x in range(XSIZE*5)])

    for x in range(0, 5*XSIZE):
        for y in range(0, 5*YSIZE):

            xs = int(x / XSIZE)
            ys = int(y / YSIZE)
            
            mdis = xs + ys
            new_cost = (((matrix[y%YSIZE][x%XSIZE] + mdis)-1)%9) + 1
            massive_grid[x][y] = new_cost
            #print(x, y)
    
    end = (len(massive_grid[0])-1, len(massive_grid)-1)
    p2 = astartv2(massive_grid, start, end)
    
    print(p1, p2)