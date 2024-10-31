
$pulse_count = 0

class Matrix
    
    attr_accessor :x_size
    attr_accessor :y_size
    attr_accessor :numbers
    attr_accessor :xcount

    def initialize(x, y, count)
        @numbers = Array.new(x*y)
        @x_size = x
        @y_size = y
        @xcount = count
        
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
    def inc(x, y)
        if x >= 0 and x <= x_size-1 and y >= 0 and y <= y_size-1
            index = x + y * x_size
            numbers[index] += 1
        end
    end

    def print_contents()
        for y in 0..y_size-1
            for x in 0..x_size-1
                print(read(x, y), ",")
            end
            print("\n")
        end
        print("\n")
    end

    def flash()
        
        for i in 0..numbers.length()-1
            numbers[i] += 1
            if numbers[i] > 9
                numbers[i] = 10
                # $pulse_count += 1
            end
        end
        #return flashes
    end

    def reset()
        for i in 0..numbers.length()-1
            if numbers[i] < 0
                numbers[i] = 0
            end
        end
    end

    def pulse()
        pulses = 0
        for y in 0..y_size-1
            for x in 0..x_size-1
                if read(x, y) > 9
                    $pulse_count += 1
                    # print(x, " ", y, " ", read(x,y), "\n")
                    inc(x-1, y-1)
                    inc(x, y-1)
                    inc(x+1, y-1)
                    # mid
                    inc(x-1, y)
                    write(x, y, -999)
                    inc(x+1, y)

                    inc(x-1, y+1)
                    inc(x, y+1)
                    inc(x+1, y+1)
                    pulses += 1
                end
            end
        end
        return pulses
    end

end
lines = File.readlines("test_11.txt")

ysize = lines.length()
xsize = lines[0].length()-1
count = 0

puts ysize
puts xsize

grid = Matrix.new(xsize, ysize, count)
buffer = Matrix.new(xsize, ysize, count)

for y in 0..ysize-1
    for x in 0..xsize-1
        grid.write(x, y, lines[y][x].to_i)
        buffer.write(x, y, -1)
    end
end

print("Before flash\n")
grid.print_contents()


for steps in 0..999999
    p_start = $pulse_count
    grid.flash()
    #print("After flash\n")
    #grid.print_contents()

    while grid.pulse() != 0
        #print("After pulse\n")
        #grid.print_contents()
    end
    grid.reset()

    #print("After reset\n")
    if $pulse_count - p_start >= 100
        print("BREAKING AT: ", steps+1, "\n")
        break
    end
    grid.print_contents()
end

print($pulse_count, "\n")