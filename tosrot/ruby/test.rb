

def func(x)
    c = 0
    for i in 0..x-1
        c += i
    end
    return c
end


for i in 0..20
    puts func(i)
end