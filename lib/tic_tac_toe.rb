require "pry"

class TicTacToe
    
    WIN_COMBINATIONS = [
    #horizontal wins
    [0,1,2],
    [3,4,5],
    [6,7,8],
    #vertical wins
    [0,3,6],
    [1,4,7],
    [2,5,8],
    #diagonal wins
    [0,4,8],
    [2,4,6]
    ]

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
        if @board[index] == " "
            return false
        else 
            return true
        end
        # @board[index] == " " ? false : true
        # @board[index] != " "
        # both of these would work last one is implicit
    end

    def valid_move?(index)
        if index.between?(0, 8) && position_taken?(index) == false
            return true
        else 
            return false
        end    
    end

    def turn_count
        @board.count{|index| index == "X" || index == "O"}
    end

    # def valid_move?(index)
    #    !position_taken?(index) && index.between?(0,8)  
    # end

    # def turn_count
    #     @board.count{|tile| tile != " "}
    # end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please enter a position (1-9):"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
            token = current_player
            move(index, token)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
                return combo
            end
        end
    end

    def full?
        @board.all?{|square| square != " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        if combo = won?
            @board[combo[0]]
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "It's a draw!"
    end
end