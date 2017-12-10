module Utils
  def self.pick(range, nb)
    if range.is_a?(Range) then
      if range.size >= nb then
        tmp = range.to_a
        res = []
        nb.times do |i|
          idx = rand(i..range.size-1)
          res << tmp[idx]
          tmp[idx], tmp[i] = tmp[i], tmp[idx]
        end
      else
        puts "Can't pick #{nb} values in #{range}"
      end
    else
      puts "#{range} has to be a range"
    end
    res
  end
end
