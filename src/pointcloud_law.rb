class PointCloud < Law
  attr_accessor :points

  def initialize(points: nil)
    @points = points
  end

  def eval(t)
    if t > @points.size then
       @points[@points.size]
    elsif t < 0 then
       @points[0]
    else
       weight  = t.modulo 1
       floored = t.floor
       weight * @points[floored] + (1 - weight) * @points[floored + 1]
    end
  end
end
