require 'minitest/autorun'
require 'minitest/pride'
require './lib/bst_node'

class NodeTest < MiniTest::Test

  def test_it_exists
    node = Node.new
    assert_instance_of Node, node
  end

end
