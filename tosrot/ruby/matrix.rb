

class Matrix
    
    attr_accessor :x_size
    attr_accessor :y_size
    attr_accessor :numbers

    def initialize(x, y)
        @numbers = Array.new(x*y)
        @x_size = x
        @y_size = y
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

    def expand(x, y) #-> returns array of coordiantes
        q = 0
        val = read(x,y)
        
        xl = x > 0 ? read(x-1, y)-val == 1 : false
        if xl
            q += expand(x-1, y)
        end

        
        return 0
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

puts counts