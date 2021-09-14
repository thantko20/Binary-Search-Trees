module Comparable
  def leaf_node?(node)
    !node.left && !node.right
  end

  def node_with_right_child(node)
    !node.left && node.right
  end

  def node_with_left_child(node)
    node.left && !node.right
  end

  def node_with_one_child(node)
    node_with_left_child(node) || node_with_right_child(node)
  end

  def node_with_both_child(node)
    node.left && node.right
  end

  def search_node(value, node)
    return if node.nil?

    value < node.data ? search_node(value, node.left) : search_node(value, node.right)
  end
end