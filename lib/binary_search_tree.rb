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

  def include?(score, node = @root)
    if score == node.score
      return true
    else
      if score > node.score
      end
    end #if node = score
  end #include




end #bst class

tree = BinarySearchTree.new
tree.insert(61, "Bill & Ted's Excellent Adventure")
tree.insert(75, "Hello World")
binding.pry
