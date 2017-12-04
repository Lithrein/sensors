require './law.rb'

class Polynom < Law
  def initialize(coefs)
    @coefs = coefs
  end

  def eval(t)
    val = 0
    (@coefs.size).times do |i|
      val = val * t + @coefs[i]
    end
    return val
  end
end
