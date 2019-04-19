require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'

class Display
    attr_reader :board

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
                val = find_val(pos)                

                # if at cursor position, make it red
                if [i, j] == cursor_pos && @cursor.selected == false
                    print " [#{val}]".colorize(:red)
                elsif [i, j] == cursor_pos && @cursor.selected == true
                    print " [#{val}]".colorize(:yellow)
                else
                    print " [#{val}]"
                end
            end

            print "\n"
        end

        puts "use arrow keys to move"
    end

    def move_cursor
        done = false    # temp boolean
        
        until done
            begin
                system("clear")
                render(@cursor.cursor_pos) # show board with cursor pos
                
                @cursor.get_input

            # if invalid position, print message and don't update cursor pos
            rescue  
                puts "Not in range"
                sleep(1)
                
                retry
            end
        end
    end

    def find_val(pos)
        # checks color first and then find the matching symbol
        case board[pos].color 
        when :white    # all white pieces
            case board[pos].symbol
            when :Rook
                "\u2656".encode('utf-8')
            when :Bishop
                "\u2657".encode('utf-8')
            when :Knight 
                "\u2658".encode('utf-8')
            when :Queen
                "\u2655".encode('utf-8')
            when :King
                "\u2654".encode('utf-8')
            when :Pawn
                "\u2659".encode('utf-8')
            end
        when :black     # all black pieces
            case board[pos].symbol
            when :Rook
                "\u265C".encode('utf-8')
            when :Bishop
                "\u265D".encode('utf-8')
            when :Knight 
                "\u265E".encode('utf-8')
            when :Queen
                "\u265B".encode('utf-8')
            when :King
                "\u265A".encode('utf-8')
            when :Pawn
                "\u265F".encode('utf-8')
            end
        when nil # for NullPieces 
            " "      
        end
    end

end

test = Display.new(Board.new)
test.move_cursor