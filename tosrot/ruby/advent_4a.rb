bingo = [91,17,64,45,8,13,47,19,52,68,63,76,82,44,28,56,37,2,78,48,32,58,72,53,9,85,77,89,36,22,49,86,51,99,6,92,80,87,7,25,31,66,84,4,98,67,46,61,59,79,0,3,38,27,23,95,20,35,14,30,26,33,42,93,12,57,11,54,50,75,90,41,88,96,40,81,24,94,18,39,70,34,21,55,5,29,71,83,1,60,74,69,10,62,43,73,97,65,15,16]

lines = File.readlines("bingocards.txt")
#puts lines

# for i in 0..lines.length() do

# end
X_SIZE = 5
Y_SIZE = 5


class Card
    
    attr_accessor :numbers
    attr_accessor :marks
    attr_accessor :has_win

    def initialize()
        @numbers = Array.new(X_SIZE*Y_SIZE)
        @marks = Array.new(X_SIZE*Y_SIZE)
        @has_win = false
        for i in 0..X_SIZE*Y_SIZE-1
            marks[i] = 0
        end
    end

    def insert(number)
        i = numbers.index(number)
        if i
            marks[i] = 1
        end
    end

    def bingo()
        # could be refactored...
        for x in 0..X_SIZE-1
            count = 0
            for y in 0..Y_SIZE-1
                count += marks[x+y*Y_SIZE]
            end
            if count == Y_SIZE
                return true
            end
        end
        for y in 0..Y_SIZE-1
            count = 0
            for x in 0..X_SIZE-1    
                count += marks[x+y*Y_SIZE]
            end
            if count == Y_SIZE
                return true
            end
        end
        return false
    end
    def sum()
        count = 0
        for i in 0..X_SIZE*Y_SIZE-1
            if marks[i] == 0
                puts numbers[i]
                count += numbers[i]
            end
        end
        return count
    end

 end


cards = Array.new

(0..lines.length()).step(6) do |i|
    #puts lines[i]
#    numbers = lines[i].split(/ +/)
    card = Card.new
    
    for y in 0..4 do
        numbers = lines[i+y].split(" ")
        for x in 0..4 do
            card.numbers[y*Y_SIZE+x] = numbers[x].to_i
        end
    end
    # print(card.numbers)
    # print(card.marks)
    cards.push(card)

    # card.insert(643)
    # break
end
# for line in lines do
    
# end

for num in bingo
    for card in cards
        card.insert(num)
        if card.bingo() and !card.has_win
            card.has_win = true
            print(card.marks)
            print(card.numbers)
            puts ""
            puts card.sum()
            puts  num
            puts card.sum() * num
           
        end
    end

end