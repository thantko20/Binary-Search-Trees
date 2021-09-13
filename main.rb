require_relative './lib/tree'

tree = Tree.new([1])
p tree.pretty_print
tree.insert(7)

p tree.pretty_print