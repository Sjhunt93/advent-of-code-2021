line = File.read("input.dat")
line = "C200B40A82"
$hex = {
    "0" => "0000",
    "1" => "0001",
    "2" => "0010",
    "3" => "0011",
    "4" => "0100",
    "5" => "0101",
    "6" => "0110",
    "7" => "0111",
    "8" => "1000",
    "9" => "1001",
    "A" => "1010",
    "B" => "1011",
    "C" => "1100",
    "D" => "1101",
    "E" => "1110",
    "F" => "1111",
}

def extract_version(val)

end


def to_binary_string(line)
    return line.chars.map { |x| $hex[x] }.join
end

# def extract_numbers()

# puts line

# line.each_char do |char|
#     puts $hex[char]
# end


# puts binary
# for i in 0..binary.length()-1
#     puts binary[i]
# end


def parse_packet_by_length(binary, length, max_packets=100000000, debug="")
    
    i = 0
    vsum = 0
    packets_parsed = 0
    while true
        # break if at the end
        break if i >= length
        break if packets_parsed >= max_packets
        # trailing 0s edge case
        break if i >= binary.length() - 6

        puts debug + " >> " + i.to_s + " -- " + length.to_s + " -- " + max_packets.to_s
        version = binary[i..i+2].to_i(2)
        vsum += version
        i += 3
        packet_type = binary[i..i+2].to_i(2)
        i += 3
        puts debug + "version is: " + version.to_s
        puts debug + "packet is: " + packet_type.to_s
        
        # break if packet_type == 0 && version == 0

        if packet_type == 4
            number_str = ''
            begin
                number_str += binary[i+1..i+4]
                i += 5
            end while binary[i-5] == '1'
            puts debug + "number string is: " + number_str + " or " + number_str.to_i(2).to_s
        else
            length_type = binary[i]
            puts debug + "length type: " + length_type
            i += 1
            if length_type == "0"
                # represents the total length in bits of the sub-packets contained by this packet.
                tlength = binary[i..i+14].to_i(2)
                i += 15
                puts debug + "sub packet length: " + tlength.to_s
                # skip
                a, b = parse_packet_by_length(binary[i..], tlength, 1000000, debug+"\t")
                vsum += a
                i += tlength
            else
                # represents the number of sub-packets immediately contained by this packet.
                num_of_packets = binary[i..i+10].to_i(2)
                i += 11
                puts debug + "number of packetss: " + num_of_packets.to_s
                a, b = parse_packet_by_length(binary[i..], 100000000, num_of_packets, debug+"\t")
                i += b
                vsum += a
            end
        end
        packets_parsed += 1
    end
    puts debug + "Parsed " + i.to_s() + " bytess. And " + packets_parsed.to_s() + " packets"
    return vsum, i
end

binary = to_binary_string(line)

a, b = parse_packet_by_length(binary, binary.length())
puts "v sum is " + a.to_s
puts b


# # print(binary)
# i = 0
# while true
#     # puts binary[i..i+3]
#     version = binary[i..i+2].to_i(2)
#     i += 3
#     packet_type = binary[i..i+2].to_i(2)
#     puts "version is: " + version.to_s
#     puts "packet is: " + packet_type.to_s
#     i += 3
#     if packet_type == 4
#         number_str = ''
#         begin
#             number_str += binary[i+1..i+4]
#             i += 5
#         end while binary[i-5] == '1'
#         puts "number string is: " + number_str + " or " + number_str.to_i(2).to_s
#     else
#         length_type = binary[i]
#         i += 1
#         if length_type == "0"
#             # represents the total length in bits of the sub-packets contained by this packet.
#             tlength = binary[i..i+14].to_i(2)
#             i += 15
#             puts "sub packet length" + tlength.to_s
#             # skip
#             i += tlength
#         else
#             # represents the number of sub-packets immediately contained by this packet.
#             num_of_ = binary[i..i+14].to_i(2)
#         end
#         puts ""
#     end


#     i += 1
#     break if i >= binary.length()-1
#     break


# end

