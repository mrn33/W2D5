require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    unless @map[key]
      val = calc!(key)
      node = Node.new(key, val)
      update_node!(node)
    else # key exists
      
    end
    
    @map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list

    if @map[node.key] # item exists
      @store.remove(node)
    end
    @map[node.key] = node
    @store.append(node.key, node.val)
  end

  def eject!
    p @map
    p @store
    key = @store.head.key
    @store.remove(key)
    @map.delete(key)
  end
end
