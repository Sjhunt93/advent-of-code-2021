line = File.read("input.dat")

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


def to_binary_string(line)
    return line.chars.map { |x| $hex[x] }.join
end


def expr(numbers, op)
  puts "doing: " + op.to_s
  case op
  when 0
    return numbers.sum
  when 1
    return numbers.reduce(1) { |prod, number| prod * number }
  when 2
    return numbers.min
  when 3
    return numbers.max
  when 5
    return numbers[0] > numbers[1] ? 1 : 0
  when 6
    return numbers[0] < numbers[1] ? 1 : 0
  when 7
    return numbers[0] == numbers[1] ? 1 : 0
  end
    raise "unhandled"
end

def parse_packet_by_length(binary, length, max_packets=100000000, debug="")
    
    i = 0
    vsum = 0
    packets_parsed = 0
    numbers = []
    while true
        # break if at the end
        break if i >= length
        break if packets_parsed >= max_packets
        # trailing 0s edge case
        break if i >= binary.length() - 6

        puts debug + " >> " + i.to_s + " -- " + length.to_s + " -- " + max_packets.to_s
        version = binary[i..i+2].to_i(2)
        i += 3
        packet_type = binary[i..i+2].to_i(2)
        i += 3

        puts debug + "version is: " + version.to_s
        puts debug + "packet is: " + packet_type.to_s
        
        
        if packet_type == 4
            number_str = ''
            begin
                number_str += binary[i+1..i+4]
                i += 5
            end while binary[i-5] == '1'
            puts debug + "number string is: " + number_str + " or " + number_str.to_i(2).to_s
            numbers.push(number_str.to_i(2))

        else
            length_type = binary[i]
            puts debug + "length type: " + length_type
            i += 1
            if length_type == "0"
                # represents the total length in bits of the sub-packets contained by this packet.
                tlength = binary[i..i+14].to_i(2)
                i += 15
                puts debug + "sub packet length: " + tlength.to_s

                a, b = parse_packet_by_length(binary[i..], tlength, 1000000, debug+"\t")
                numbers.push(expr(a, packet_type))
                i += tlength
            else
                # represents the number of sub-packets immediately contained by this packet.
                num_of_packets = binary[i..i+10].to_i(2)
                i += 11
                puts debug + "number of packetss: " + num_of_packets.to_s
                a, b = parse_packet_by_length(binary[i..], 100000000, num_of_packets, debug+"\t")
                numbers.push(expr(a, packet_type))
                i += b
            end
        end
        puts debug + "acculation ** " + numbers.join(", ")
  
        packets_parsed += 1
    end
    puts debug + "Parsed " + i.to_s() + " bytess. And " + packets_parsed.to_s() + " packets"
    return numbers, i
end

# line = "9C0141080250320F1802104A08"

binary = to_binary_string(line)

a, b = parse_packet_by_length(binary, binary.length())
puts a