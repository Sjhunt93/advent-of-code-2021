

lines = File.readlines("input.dat")
#puts lines
pos_x = 0
depth = 0
aim = 0
count = lines.length()
digit_amount = 12
arr1 = Array.new(digit_amount)
for i in 0..11 do
    arr1[i] = 0
end
for line in lines do
        for i in 0..11 do
            arr1[i] += line[i].to_i
        end
    end
print(count)
print(arr1)
puts ""
gamma = ""
epsilon = ""
for i in 0..11 do
    if arr1[i] > 500
        gamma += "1"
        epsilon += "0"
    else
        gamma += "0"
        epsilon += "1"
    end
end
puts gamma.to_i(2)
puts epsilon.to_i(2)

puts gamma.to_i(2) * epsilon.to_i(2)
