
graph = {}

def dfs(current, target, visited: list):

    if current == target:
        return 1

    r = 0
    for paths in graph[current]:
        if paths.islower() and paths not in visited:
            r += dfs(paths, target, visited + [paths])
        elif paths != "start" and not paths.islower():
            r += dfs(paths, target, visited + [paths])
    
    return r

with open("data.txt") as f:
    lines = f.read().split("\n")
    for l in lines:
        print(l)
        a, b = l.split("-")
        if a in graph:
            graph[a].append(b)
        else:
            graph[a] = [b]

        if b in graph:
            graph[b].append(a)
        else:
            graph[b] = [a]
    
    print(graph)


r = dfs("start", "end", ["start"])
print(r)