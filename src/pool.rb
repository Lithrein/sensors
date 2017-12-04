require "observer"

class Pool
  attr_accessor :name, :captors, :law
  include Observable

  @@id_max = 0
  
  def initialize(name: "", captors: [], law: nil, geometry: :flat, options: nil)
    @id       = @@id_max
    @name     = name
    @captors  = captors
    @law      = law
    @options  = options
    @geometry = geometry
    @threads = []

    @@id_max += 1
  end

  def options=(opts)
    @options = opts
  end

  def add_machine(machine)
    self.add_observer(machine)
  end

  def run
    # Divide the sensor pool in 500-sensor baskets
    nb_threads = 1 + (captors.size / 500)
    while true do
      changed
      nb_threads.times do |nb|
        min = nb * 500
        max = min + 499
        @threads << Thread.new { @captors[min..max].each { |c| c.state = @law.eval(0) } }
      end
      @threads.each { |t| t.join }
      @threads = []
      notify_observers(@captors)
    end
  end
end
