
graph = {}

def dfs(current, target, visited: list, special):

    if current == target:
        return [visited]

    results = []
    for paths in graph[current]:
        if paths.islower() and paths not in visited:
            if paths == special and "~" not in visited:
                results += dfs(paths, target, visited + ["~"], special)
            else:
                results += dfs(paths, target, visited + [paths], special)
            

        elif paths != "start" and not paths.islower():
            results += dfs(paths, target, visited + [paths], special)
            
    
    return results

tokens = set()

with open("11/data.txt") as f:
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

        if a.islower():
            tokens.add(a)
        if b.islower():
            tokens.add(b)
        
    print(graph)

tokens.remove("start")
tokens.remove("end")
print(tokens)

results = []
for t in tokens:
    paths = dfs("start", "end", ["start"], t)
    results += [''.join(i).replace("~", t) for i in paths]
    

print(len(set(results)))
# final = set([tuple(i) for i in r])
# for f in final:
#     print(f)
