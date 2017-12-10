require './app'

#Law.define :RandomLaw do
#  type :behavior
#  parameters :range
#  run -> (time, neighbors, sensor) { rand(@range) }
#end

Law.define :PolynomLaw do
  type :overview
  parameters :coefs
  run -> (time) {
    val = 0
    (@coefs.size).times do |i|
      val = val * time + @coefs[i]
    end
    return val
  }
end

Simulation.define do
  name "Test App"  
  
  create Pool do
    name "Pool 1"
    captors Array.new(10){Sensor.new}
    #    law RandomLaw.new 1..2
    law PolynomLaw.new [50]
    options :chaos_monkey
  end
  
  create Computer do
    name "Computer 1"
    database "test"
    user "test"
    password "test"
  end
  
  monitor "Pool 1", with: "Computer 1"
end
