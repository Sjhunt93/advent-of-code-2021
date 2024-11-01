
lines = File.readlines("input.dat")

def find_raiting(lines, y_size, type)
    
    for i in 0..y_size do
        next_lines = Array.new
        count = 0
        if lines.length() == 1
            return lines[0]
        end
        for line in lines do
            count += line[i].to_i
        end
        if type == "oxygen"
            to_keep = count >= lines.length() / 2.0 ? "1" : "0"
        elsif type == "c02"
            to_keep = count >= lines.length() / 2.0 ? "0" : "1"
        end
        #puts to_keep
        
        for line in lines do
            if line[i] == to_keep
                next_lines.push(line)
                #puts line
            end
        end
        lines = next_lines
    end
    return lines[0]
end

puts find_raiting(lines, 11, "oxygen").to_i(2)
puts find_raiting(lines, 11, "c02").to_i(2)

# pos_x = 0
# depth = 0
# aim = 0
# count = lines.length()
# digit_amount = 12
# arr1 = Array.new(digit_amount)
# for i in 0..11 do
#     arr1[i] = 0
# end
# for line in lines do
#         for i in 0..11 do
#             arr1[i] += line[i].to_i
#         end
#     end
# print(count)
# print(arr1)
# puts ""
# gamma = ""
# epsilon = ""
# for i in 0..11 do
#     if arr1[i] > 500
#         gamma += "1"
#         epsilon += "0"
#     else
#         gamma += "0"
#         epsilon += "1"
#     end
# end
# puts gamma.to_i(2)
# puts epsilon.to_i(2)

# puts gamma.to_i(2) * epsilon.to_i(2)
