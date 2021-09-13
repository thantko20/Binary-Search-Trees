require_relative 'node'
require 'pry-byebug'

# Tree class
# Initialized with array as argument
# must have root attr
# which a a return value of #build_tree method

# Init
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.sort.uniq)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.size/2
    node = Node.new(arr[mid])
    node.left = build_tree(arr.slice(0, mid))
    node.right = build_tree(arr.slice(mid+1, arr.size))

    return node
  end

  def insert(value, node=@root)
    #binding.pry
    return node.left = Node.new(value) if node.nil? && node.data > value

    return node.right = Node.new(value) if node.right.nil? && node.data < value

    value < node.data ? insert(value, node.left) : insert(value, node.right)
  end

  # say i have a value which node is leaf node
  def deletion(value, node=@root)
    return node.left = nil if node.left.data == value

    return node.right = nil if node.right.data == value

    value < node.data ? deletion(value, node.left) : deletion(value, node.right)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def check_node(node=@root)
    check_leaf_node(node)
  end

  private

  def check_leaf_node(node)
    node.left.nil? && node.right.nil?
  end
end