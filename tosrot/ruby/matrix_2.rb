require 'colorize'


class Matrix
    
    attr_accessor :x_size
    attr_accessor :y_size
    attr_accessor :numbers
    attr_accessor :indexs
    attr_accessor :start
    attr_accessor :first

    def initialize(x, y)
        @numbers = Array.new(x*y)
        @indexs = Array.new
        @x_size = x
        @y_size = y
        @start = -1
        @first = false
        for i in 0..x_size*y_size-1
            numbers[i] = 0
        end
    end

    def read(x, y)
        index = x + y * x_size
        return numbers[index]
    end
    def write(x, y, val)
        index = x + y * x_size
        # if val == 9
        #     val = 100
        # end
        numbers[index] = val
    end
    def is_low(x,y)
        val = read(x,y)
        xl = x > 0 ? read(x-1, y) > val : true
        xr = x < x_size-1 ? read(x+1, y) > val : true
        yu = y > 0 ? read(x, y-1) > val : true
        yd = y < y_size-1 ? read(x, y+1) > val : true
        if (xl and xr and yu and yd)
            return val+1
        else
            return 0
        end
    end

    # def expand(x, y) #-> returns array of coordiantes
    #     q = 0
    #     val = read(x,y)
        
    #     xl = x > 0 ? read(x-1, y)-val == 1 : false
    #     if xl
    #         q += expand(x-1, y) #+1
    #         indexs.push(x-1 + (y*x_size))
    #     end
    #     xr = x < x_size-1 ? read(x+1, y)-val == 1 : false
    #     if xr
    #         q += expand(x+1, y)
    #         indexs.push(x+1 + (y*x_size))
    #     end

    #     yu = y > 0 ? read(x, y-1)-val == 1 : false
    #     if yu
    #         q += expand(x, y-1)
    #         indexs.push(x + ((y-1)*x_size))
    #     end
    #     yd = y < y_size-1 ? read(x, y+1)-val == 1 : false
    #     if yd
    #         q += expand(x, y+1)
    #         indexs.push(x + ((y+1)*x_size))
    #     end
        
    #     a = xl ? 1 : 0
    #     b = xr ? 1 : 0
    #     c = yu ? 1 : 0
    #     d = yd ? 1 : 0
    #     t = a+b+c+d
    #     #print(xl, " ", xr, " ", yu, " ", yd, " = ", t, "\n")
    #     return q+t
    #     return a+b+c+d
    # end

    def expand(x, y) #-> returns array of coordiantes
        q = 0
        val = read(x,y)
        
        write(x, y, 9)

        # if (x + y * x_size) == start and first == false
        #     return q
        # end
        # first = true
        

        xl = x > 0 ? read(x-1, y) != 9 : false
        if xl
            q += expand(x-1, y) #+1
            indexs.push(x-1 + (y*x_size))
        end
        xr = x < x_size-1 ? read(x+1, y) != 9 : false
        if xr
            q += expand(x+1, y)
            indexs.push(x+1 + (y*x_size))
        end

        yu = y > 0 ? read(x, y-1) != 9 : false
        if yu
            q += expand(x, y-1)
            indexs.push(x + ((y-1)*x_size))
        end
        yd = y < y_size-1 ? read(x, y+1) != 9 : false
        if yd
            q += expand(x, y+1)
            indexs.push(x + ((y+1)*x_size))
        end
        
        a = xl ? 1 : 0
        b = xr ? 1 : 0
        c = yu ? 1 : 0
        d = yd ? 1 : 0
        t = a+b+c+d
        #print(xl, " ", xr, " ", yu, " ", yd, " = ", t, "\n")
        return q+t
        return a+b+c+d
    end


    # -> 
    def go_up(x, y)
        yu = y > 0 ? read(x, y-1) > val : true
    end




end
lines = File.readlines("geomap2.txt")

ysize = lines.length()
xsize = lines[0].length()-1

puts ysize
puts xsize

grid = Matrix.new(xsize, ysize)

for y in 0..ysize-1
    for x in 0..xsize-1
        grid.write(x,y,lines[y][x].to_i)
    end
end

counts = 0
for y in 0..ysize-1
    for x in 0..xsize-1
        #if grid.is_low(x,y)
        counts += grid.is_low(x,y)
        #end
    end
end

outs = Array.new

for y in 0..ysize-1
    for x in 0..xsize-1
        if grid.is_low(x,y) >= 1
            grid.indexs = Array.new
            grid.start = x + y * grid.x_size
            grid.first = false
            print("EXPANDing at: ", x, " - ", y, "\n")
            q = grid.expand(x,y)
            if q > 0
                #print(q, "\n")
                print(grid.indexs)
                a = grid.indexs.uniq.length()+1
                print(a, "\n")
                outs.push(a)
            end
        end
        #print(grid.read(x,y).to_s.red)
    end
    #print("\n")
end

print(outs.sort)
