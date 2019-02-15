class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.to_s.hash
  end
end

class String
  def hash
    code = 0
    self.each_char.with_index do |char,i|
      code +=char.sum*(i+1)
    end
    code.object_id.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    code = 0
    self.each do |el|
      code += el.hash
    end
    code.hash
  end
end
