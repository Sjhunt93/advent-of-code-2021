$open_brackets = "([{<"
$closed_brackets = ")]}>"

# test code
def print_recursive(test_str_items)
    if test_str_items.length() > 0
        bracket = test_str_items.shift()
        puts bracket
        print_recursive(test_str_items)
        puts test_str_items.length()
    end
end


# test_str_itesm should be an array
# current bracket is the current open bracket i.e. ( or ""
# depth is used for debugging only
# to close is the brackets that should be closed by the function in the stack
def compile(test_str_items, current_bracket, depth, to_close)

    # test_str_items will get smaller
    for i in 0..test_str_items.length()-1
        if test_str_items.length() > 0
            bracket = test_str_items.shift()

            # is an open bracket
            if $open_brackets.include? bracket
                #print(depth, "# Open: ", bracket, ":: ", test_str_items.length(), "\n")
                to_close += bracket
                to_close = compile(test_str_items, bracket, depth+1, to_close)
                
            else
                # bit of a hack to loop up the matching pair
                i = $open_brackets.index(current_bracket) 
                closed_pair = $closed_brackets[i]
                if closed_pair != bracket
                    return "ERROR -> mismatched " + closed_pair + " should be: " + bracket
                else
                    to_close = to_close.chop
                    #print(depth, "# Closed: ", bracket, ":: ", test_str_items.length(), " - ", to_close, "\n")
                    return to_close
                end
                
            end
        end
    end
    return to_close
    
end

map = { "(" => ")", "[" => "]", "{" => "}", "<" => ">" }
cost = { ")" => 1, "]" => 2, "}" => 3, ">" => 4}

test_str = "(((({<>}<{<{<>}{[]{[]{}"
# puts(compile(test_str.split(""), "", 0, ""))
# remain = compile(test_str.split(""), "", 0, "").reverse

scores = Array.new
lines = File.readlines("navcodes2.txt")
for l in lines
    items = l.split("")
    items.pop
    remain = compile(items, "", 0, "")
    puts(remain)
    if remain.include? "ERROR"
        puts "corrupts"
    else
        
        score = 0
        for x in remain.reverse.split("")
            score = (score * 5) + cost[map[x]]
        end

        
        scores.push(score)
    end
end
scores = scores.sort
print(scores, "\n")
print(scores[scores.length/2], "\n")








