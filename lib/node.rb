class Node
  attr_accessor :score,
                :name,
                :greater_child,
                :lesser_child,
                :depth

  def initialize(score, name)
    @score = score
    @name = name
    @greater_child = nil
    @lesser_child = nil
    @depth = 0
  end

end
