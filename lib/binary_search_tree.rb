require_relative "./node"
require "pry"

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(score, name)
    node = Node.new(score, name)
    if @root == nil
      @root = node
    else
      place_node(node, @root)
      # @root.insert(node)
    end #if root nil
    node.depth
  end #insert

  def place_node(new_node, top_node)
    new_node.depth += 1
    if new_node.score > top_node.score
      if top_node.greater_child.nil?
        top_node.greater_child = new_node
      else
        place_node(new_node, top_node.greater_child)
      end # if top nil
    else
      if top_node.lesser_child.nil?
        top_node.lesser_child = new_node
      else
        place_node(new_node, top_node.lesser_child)
      end #if top nil
    end #if new > top
  end #place_node

  def include?(score)
    !find_node(score).nil?
  end #include

  def depth_of(score)
    node = find_node(score)
    node.nil? ? nil : node.depth
  end

  def find_node(score, node = @root)
    result_node = nil
    if score == node.score
      result_node = node
    else
      if score > node.score
        result_node = node.greater_child.nil? ? nil : find_node(score, node.greater_child)
      else
        result_node = node.lesser_child.nil? ? nil : find_node(score, node.lesser_child)
      end #score > node
    end #if node = score
    result_node
  end #find node

  def max(node = @root)
    node.greater_child.nil? ? node : max(node.greater_child)
  end

  def min(node = @root)
    node.lesser_child.nil? ? node : min(node.lesser_child)
  end

  def sort
    @root.to_a
  end



end #bst class

tree = BinarySearchTree.new
tree.insert(61, "Bill & Ted's Excellent Adventure")
tree.insert(75, "Hello World")
binding.pry
