require './app'

Simulation.define do
  name "Test App"
  
  create Pool do
    name "Pool 1"
    captors Array.new(10){Sensor.new}
    law RandomLaw.new 1..2
  end
  
  create Computer do
    name "Computer 1"
    database "test"
    user "test"
    password "test"
  end

  monitor "Pool 1", with: "Computer 1"
end
