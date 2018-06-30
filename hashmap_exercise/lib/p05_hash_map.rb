require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    unless include?(key)
      @store[key.hash % num_buckets].append(key, val)
      @count += 1
      resize! if @count == num_buckets
    else
      @store[key.hash % num_buckets].update(key, val)
    end
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    @count -= 1 if @store[key.hash % num_buckets].remove(key) 
  end

  def each(&prc)
    @store.each do |list|
      list.each { |node| prc.call(node.key, node.val) }
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    store1 = Array.new(2 * num_buckets) { LinkedList.new }
    
    @store.each do |list|
      list.each do |node|
        store1[node.key.hash % store1.length].append(node.key, node.val)
      end
    end
    
    @store = store1
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    
  end
end
