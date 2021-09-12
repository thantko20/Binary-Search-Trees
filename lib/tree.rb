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

  private

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.size/2
    node = Node.new(arr[mid])
    node.left = build_tree(arr.slice(0, mid))
    node.right = build_tree(arr.slice(mid+1, arr.size))

    return node
  end

  public

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end