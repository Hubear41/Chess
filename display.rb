require 'colorize'
require_relative 'cursor.rb'

class Display
    attr_reader :board
    attr_accessor :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render(cursor_pos)
        selected_pos = @cursor_pos.selected_pos if @cursor.selected

        # if there is a selected position, assign it and it's valid positions
        if @cursor.selected && board[selected_pos].empty?
            selected_piece = board[selected_pos] 
            valid_moves = curr_piece.valid_moves
        end
        
        # Create column numbers
        (0..7).each do |num|
            print " "
            print "  #{num}"
        end

        print "\n"

        # Create row number with rows
        (0..7).each do |i|
            print "#{i}"

            (0..7).each do |j|
                 # val = ' '
                pos = [i,j]
                             

                # if at cursor position, make it red
                if [i, j] == cursor_pos && @cursor.selected == false
                    print " [" + board[pos].symbol + "]".colorize(:red)

                # if a location is highlighted, change color to yellow    
                elsif [i, j] == cursor_pos && @cursor.selected == true
                    print " [" + board[pos].symbol + "]".colorize(:yellow)

                #     
                elsif @cursor.selected && valid_moves.include?([i, j])
                    print " [" + board[pos].symbol + "]".colorize(:green)
                else
                    print " [" + board[pos].symbol + "]"
                end
            end

            print "\n"
        end

        puts "use arrow keys to move"
    end

end