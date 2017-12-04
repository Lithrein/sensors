##
# This class represent a sensor. A sensor is represented by a state and this
# state can be whatever
class Sensor
  attr_writer :state
  attr_reader :id

  @@id_max = 0

  def initialize(state: nil)
    @id = @@id_max
    @state = state

    @@id_max += 1
  end

  def state
    if state == "broken" then
      nil
    else
      state
    end
  end
end
