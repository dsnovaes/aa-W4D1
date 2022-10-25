require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    # base case
    if board.over? && board.winner != evaluator
      return true
    elsif board.over? && (board.winner == nil || board.winner == evaluator)
      return false
    end

    # recursive step

    

    
  end

  def winning_node?(evaluator)
    return true if board.over? && board.winner == evaluator
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    new_children = []
    (0...board.rows.length).each do |i|
      (0...board.rows.length).each do |j|
        if board.empty?([i,j])
          new_board = board.dup
          new_mark = change_move(next_mover_mark)
          new_board.rows[i][j] = new_mark
          hello = TicTacToeNode.new(new_board, new_mark, [i,j]) 
          new_children << hello
        end
      end
    end
    return new_children
  end

  def change_move(next_mover_mark)
    if next_mover_mark == :x
      next_mover_mark = :o
    else
      next_mover_mark = :x
    end
    return next_mover_mark
  end
end

my_node = TicTacToeNode.new(Board.new,:x)
# p my_node
# p my_node.board
# p my_node.board.rows.length
# p my_node.board.rows[0][0]
p my_node.children
# p my_node.board