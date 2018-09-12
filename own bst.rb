require 'pry'
require 'byebug'

class RBF
    def initialize
        @face = ":|"
    end
end

class BSTNode
    attr_accessor  :value, :left, :right
    def initialize(value)
        @value = value
        @left = nil
        @right = nil
    end
end

class BST
    attr_accessor :root

    def initialize
        @root = nil
    end

    def find(value, node = @root)
        # debugger
        return node if node.value == value
        raise "Error: Not Found" if node.nil?

        if value < node.value
            return find(value, node.left)
        else
            return find(value, node.right)
        end
    end

    def insert(value, node = @root)
        if @root.nil?
            # debugger
            @root = BSTNode.new(value)
            return @root
        end
        if node.nil?
            node = BSTNode.new(value) 
        else
            if value < node.value
                node.left = insert(value, node.left)
            else
                node.right = insert(value, node.right)
            end
        end
        node
    end

    def delete(value)
        # p @root
        @root = delete_node(value, @root)
    end

    def depth(node)
        if node.nil?
            return -1
        else
            left_depth = depth(node.left)
            right_depth = depth(node.right)
            if left_depth > right_depth
                return left_depth + 1
            else 
                return right_depth + 1
            end
        end
    end

    def is_balanced?(node)
        return true if node.nil?
        balanced = true
        left_depth = depth(node.left)
        right_depth = depth(node.right)
        balanced = false if (left_depth - right_depth).abs > 1
        return true if balanced && is_balanced?(node.left) && is_balanced?(node.right)
        false
    end

    def in_order_traversal(node, arr)
        if node.left
            in_order_traversal(node.left, arr)
        end

        arr.push(node)

        if node.right
            in_order_traversal(node.right, arr)
        end
       
        arr
    end
    
    def delete_node(value, node)
        # debugger
        if value == node.value
            node =  remove(node) 
        elsif value < node.value
            node.left = delete_node(value, node.left)
        else 
            node.right = delete_node(value, node.right)
        end
        node
    end

    def remove(node)
        if node.left.nil? && node.right.nil?
            node = nil
        elsif node.left.nil? && node.right
            node = node.right
        elsif node.right.nil? && node.left
            node = node.left
        else
            tempL = node.left
            tempR = node.right
            node = find_max_and_do_stuff(node)
            node.left = tempL #check for nil 
            node.right = tempR
        end
        node
    end

    def find_max_and_do_stuff(node)
        parent = node.left
        current = parent.right
        return parent if current.nil?
        max = current
        until current.right.nil?
            parent = parent.right
            current = current.right
            max = current
        end
        # debugger

        if max.left
            parent.right = max.left
            max.left = nil
        end

        return max
    end
end

tree = BST.new
root = tree.insert(4)
tree.insert(2,root)
tree.insert(1,root)
tree.insert(3,root)
tree.insert(1.2,root)
tree.insert(1.1,root)
tree.insert(0.4,root)
# tree.delete(2)
p tree.in_order_traversal(root, [])
binding.pry


