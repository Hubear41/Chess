require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'

class Display
    attr_reader :board
    attr_accessor :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render(cursor_pos)
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
                elsif [i, j] == cursor_pos && @cursor.selected == true
                    print " [" + board[pos].symbol + "]".colorize(:yellow)
                else
                    print " [" + board[pos].symbol + "]"
                end
            end

            print "\n"
        end

        puts "use arrow keys to move"
    end

    # def find_val(pos)
    #     # checks color first and then find the matching symbol
    #     case board[pos].color 
    #     when :white
    #         board[pos].symbol.colorize(:white)
    #         " "      
    #     end
    # end

end

test = Display.new(Board.new)
test.move_cursor