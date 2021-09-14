require_relative './lib/tree'

tree = Tree.new(Array.new(15) { rand(1..100) })

tree.pretty_print
p tree.balance?
p tree.level_order
p tree.preorder
p tree.inorder
p tree.postorder

tree.insert(101)
tree.insert(1000)
tree.insert(200)
tree.insert(432)

tree.pretty_print
p tree.balance?

tree.rebalance

tree.pretty_print

p tree.balance?
p tree.level_order
p tree.preorder
p tree.inorder
p tree.postorder