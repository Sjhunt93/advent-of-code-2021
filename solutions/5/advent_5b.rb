lines = File.readlines("input.dat")

GRID = 1000

big_array = Array.new(GRID*GRID)
big_array.each { |x| x=0 }

for i in 0..(GRID*GRID-1)
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
    
    deg = (y1-y2).abs - (x1-x2).abs

    if x1 == x2 or y1 == y2 or deg == 0
        print(x1, " ", y1, " -> ", x2, " ", y2, "\n")
        yd = (y1-y2).abs
        xd = (x1-x2).abs
        xstart = [x1, x2].min
        ystart = [y1, y2].min
        
        print(xd, " ", yd, "\n")
        print("start ", xstart, " ystart ", ystart, "\n")

        

        if yd == xd
            # need to factor in direction here.....
            
            m = (y2-y1) / (x2-x1)
            puts(m)

            # line goes up
            if m == -1
                puts "goes up"
                for x in xstart..(xstart+xd)
                    y = (((ystart+yd) - (x-xstart)) * GRID)
                    x = x
                    print("y = ", y, "\n")
                    print("x = ", x, "\n")
                    index = x + y
                    big_array[index] += 1
                end
            else           
                puts "goes down" 
                for x in xstart..(xstart+xd)
                    
                    index = x + ((ystart+(x-xstart)) * GRID)
                    
                    big_array[index] += 1
                end
            end
        elsif yd > 0
            
            
            for y in ystart..(ystart+yd)
                index = xstart + (y * GRID)
                big_array[index] += 1
            end
        
        elsif xd > 0
            for x in xstart..(xstart+xd)
                index = x + (ystart * GRID)
                big_array[index] += 1
            end
        end
        
        # for i in 0..(GRID*GRID-1)
        #     if big_array[i] == 0
        #         print(".")
        #     else
        #         print(big_array[i])
        #     end
        #     if i%GRID == GRID-1
        #         print("\n")
        #     end
        # end
        # print("\n")
        

        

    end
    
end

c = 0
for i in 0..(GRID*GRID-1)
    # if big_array[i] == 0
    #     print(".")
    # else
    #     print(big_array[i])
    # end
    # if i%GRID == GRID-1
    #     print("\n")
    # end
    if big_array[i] >= 2
        c+=1
    end
end

print("\n", c, "\n")

# 3,3 -> 3,9 (vertical)
# 2,1 -> 9,1 (horizontal)