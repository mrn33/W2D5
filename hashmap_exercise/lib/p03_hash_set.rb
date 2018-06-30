class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      self[key] << key
      @count += 1
      resize! if @count == num_buckets - 1
      return true
    end
    
    false
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    store1 = Array.new(2 * num_buckets) { Array.new }
    
    @store.each do |bucket|
      bucket.each do |el|
        store1[el.hash % store1.length] << el
      end
    end
    @store = store1
  end
end
