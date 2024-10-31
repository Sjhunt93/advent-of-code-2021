lines = File.readlines("lines.txt")

big_array = Array.new(1000*1000)
big_array.each { |x| x=0 }

for i in 0..(1000*1000-1)
    big_array[i] = 0
end
for l in lines
    #a = /\d+/.match(l)
    a = l.split(/[ ,[->|\n]]/).reject { |c| c.empty? }
    #a  = l.match(/\d+/)
    x1 = a[0].to_i
    y1 = a[1].to_i
    x2 = a[2].to_i
    y2 = a[3].to_i
    
    if x1 == x2 or y1 == y2
        print(x1, " ", y1, " -> ", x2, " ", y2, "\n")
        yd = (y1-y2).abs
        xd = (x1-x2).abs
        xstart = [x1, x2].min
        ystart = [y1, y2].min
        print(xd, " ", yd, "\n")
        print(xstart, " ", ystart, "\n")
        if yd > 0
            
            
            for y in ystart..(ystart+yd)
                index = xstart + (y * 1000)
                big_array[index] += 1
            end
        end
        if xd > 0
            for x in xstart..(xstart+xd)
                index = x + (ystart * 1000)
                big_array[index] += 1
            end
        end
            

        

    end
    
end

c = 0
for i in 0..(1000*1000-1)
    
    if big_array[i] >= 2
        c+=1
    end
end

print("\n", c, "\n")

# 3,3 -> 3,9 (vertical)
# 2,1 -> 9,1 (horizontal)