





$open_brackets = "([{<"
$closed_brackets = ")]}>"

#
# test_str should be an array
def compile(test_str_items, current_bracket, depth)

    for i in 0..test_str_items.length()-1
        if test_str_items.length() > 0
            bracket = test_str_items.shift()
            if $open_brackets.include? bracket
                #print(depth, "# Open: ", bracket, ":: ", test_str_items.length(), "\n")
                r = compile(test_str_items, bracket, depth+1)
                if r.length() != 0
                    return r
                end
            else
                i = $open_brackets.index(current_bracket) 
                closed_pair = $closed_brackets[i]
                if closed_pair != bracket
                    return "ERROR -> mismatched " + closed_pair + " should be: " + bracket
                else
                    #print(depth, "# Closed: ", bracket, ":: ", test_str_items.length(), "\n")
                    return ""
                end
                
                #return compile(test_str_items, "", depth+1)

            end
        end
    end
    return ""
    
end

def count_for_char(c, str)
    return str.count(c)
end

def count_for_chars_in_str(char_str, test_str)
    open_c = 0
    char_str.split("").each { |c| 
        open_c += count_for_char(c, test_str)
    }
    return open_c
end

test_str = "[({(<(())[]>[[{[]{<()<>>"
puts test_str.length()
puts count_for_chars_in_str($open_brackets, test_str)
puts count_for_chars_in_str($closed_brackets, test_str)

#items = 
#puts items
puts(compile(test_str.split(""), "", 0))
puts(compile(test_str.split(""), "", 0))
puts(compile(test_str.split(""), "", 0))

#puts(compile("(>".split(""), ""))
#puts(compile("{(<>)}".split(""), "", 0))

map = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25137 }


fuck_up = 0
lines = File.readlines("navcodes.txt")
for line in lines
    items = line.split("")[0..-2]
    #print(items, "\n")
    a = compile(items, "", 0)
    if a.length() > 0
        print(line, "~", a, "\n")
        bad = a[-1]
        print(bad, map[bad], "\n")
        fuck_up += map[bad]

    end
    
end
print(fuck_up)
# for c in open_brackets
#     puts c
# end