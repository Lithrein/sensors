require "observer"

class Pool
  include Observable

  @@id_max = 0

  OPTIONS = [ :chaos_monkey ].freeze
  
  def initialize(name: "", captors: [], law: nil, geometry: :flat, options: {})
    @id       = @@id_max
    @name     = name
    @captors  = captors
    @law      = law
    @options  = options
    @geometry = geometry
    @threads = []

    @@id_max += 1
  end

  def name(name)
    @name = name
  end

  def get_name
    @name
  end

  def captors(captors)
    @captors = captors
  end

  def law(law)
    @law = law
  end

  def add_machine(machine)
    self.add_observer(machine)
  end

  def options(*opts)
    opts.each do |opt|
      if OPTIONS.index opt then
        @options[opt] = true
      else
        puts "The option #{opt} is not supported."
      end
    end
  end
  
  def run
    # Divide the sensor pool in 500-sensor baskets
    nb_threads = 1 + (@captors.size / 500)
    loop do
      changed
      nb_threads.times do |nb|
        min = nb * 500
        max = min + 499
        @threads << Thread.new {
          if @law.type == :overview then
            percent = @law.run(Time.new.hour + Time.new.min / 60)
            to_on = Utils.pick(min..max, (min..max).size * percent / 100)
            @captors[min..max].each { |c|
              c.state = if to_on.index c then 1 else 0 end
            }
          else
            @captors[min..max].each { |c|
              c.state = @law.run(0,0,0)
            }
          end
        }
      end
      @threads.each { |t| t.join }
      @threads = []
      notify_observers(@captors)
    end
  end
end
