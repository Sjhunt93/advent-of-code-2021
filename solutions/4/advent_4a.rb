lines = File.readlines("input.dat")


bingo = lines[0].split(',').map(&:to_i) 

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

(2..lines.length()).step(6) do |i|
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