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

  def to_h
    {name => score}
  end

  def to_a
    lesser_child.to_a + [to_h] + greater_child.to_a
  end


end
