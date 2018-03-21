class Node
  attr_accessor :score,
                :name,
                :greater,
                :lesser,
                :depth

  def initialize(score, name)
    @score = score
    @name = name
    @greater = nil
    @lesser = nil
    @depth = 0
  end

  def to_a
    lesser.to_a + [{name => score}] + greater.to_a
  end


end
