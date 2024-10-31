#file = File.open("sub2.txt")
# File.foreach("sub2.txt") {
#     |line| puts line
#     
#         puts "xx"
# }

lines = File.readlines("sub2.txt")
#puts lines
pos_x = 0
depth = 0
aim = 0
for line in lines do
    puts line
    if line.include? "forward"
        val = line[/ (\d+)/,1].to_i
        pos_x += val
        depth += aim * val 
    end
    if line.include? "down"
        aim += line[/ (\d+)/,1].to_i
    end
    if line.include? "up"
        aim -= line[/ (\d+)/,1].to_i
    end
  end
puts pos_x
#puts "depth:", depth

puts "position #{pos_x}!"
puts "depth #{depth}!"
puts "total #{depth*pos_x}!"

# file_data = file.readlines.map(&:chomp)
# file_data
# file.close

