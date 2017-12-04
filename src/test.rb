require './app'

module Simulation
  @registry = []

  def self.registry
    @registry
  end

  def self.define(&block)
    definition_proxy = DefinitionProxy.new
    definition_proxy.instance_eval(&block)
  end
end

class DefinitionProxy
  def create(build_class, &block)
    instance = build_class.new
    instance.instance_eval(&block)
    Simulation.registry << instance
  end
end

Simulation.define do
  create Pool do
    self.name= "Pool de test"
    self.captors= Array.new(10){Sensor.new}
    self.law= RandomLaw.new 1..2
  end
end

p Simulation.registry[0]

#app = App.new
#app.name = "test"

#machine = Computer.new(database: "test", user: "test", password:"test")

#captors = Array.new(5000){Sensor.new}

#pool = Pool.new
#pool.name = "Pool de test"
#pool.captors = captors
#pool.law = RandomLaw.new 1..2
#pool.add_machine(machine)

#app.add_pool(pool)

#app.run
