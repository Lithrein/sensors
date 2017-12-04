class RandomLaw < Law
  def initialize(range)
    @range = range
  end

  def eval(time)
    rand(@range)
  end
end
