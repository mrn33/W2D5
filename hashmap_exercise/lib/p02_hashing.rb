require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    primes = [1021, 2111, 4157, 6113, 7753]
    
    fixnum = 0
    self.each_index do |i|
      fixnum += (self[i] * i) * primes[i % primes.length] if self[i].is_a? Fixnum
      fixnum += self[i].hash if self[i].is_a?(String) || self[i].is_a?(Hash)
    end
    fixnum.hash
  end
end

class String
  def hash
    operation = [:+, :-, :*, :/]
    p self.chars
    ascii_values = []
    self.chars.each_with_index { |chr, idx| ascii_values << chr.ord % (idx + 1) }
    ascii_values.reduce(1, operation[ascii_values.length % operation.length])
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end


if __FILE__ == $PROGRAM_NAME
  # a = [1, 2, 3]
  # b = [3, 2, 1]
  # c = [1, 2, 3]
  # 
  # p a.hash
  # p b.hash
  # p c.hash
  # 
  # str = "abcd"
  # p str.hash
  # str = "abcc"
  # p str.hash
  
  # debugger
  arr = ["hello", 12312, "World"]
  arr2 = ["World", 12312, "hello"]
  p arr2
  p arr.hash
  p arr2.hash
end