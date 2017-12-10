# coding: utf-8
require './law'
#require './pointcloud_law'
#require './random_law'
require './pool'
require './sensor'
require './computer'
require './utils'

module Simulation
  @app = nil

  def self.app
    @app
  end

  def self.define(&block)
    unless @app
      @app = App.new
      @app.instance_eval(&block)
      @app.run
    else
      puts "Can't define two apps"
    end
  end
end

class App
  BACKENDS = [ :influxdb ].freeze
  
  def initialize(name: nil, pools: Hash.new(nil), machines: Hash.new(nil))
    @name = name
    @pools = pools
    @machines = machines
    @options = Hash.new(nil)
  end

  def run
    @pools.each { |name, pool| pool.run }
  end

  def add_pool(pool)
    unless @pools[pool.get_name] 
      @pools[pool.get_name] = pool
    else
      puts "A pool name #{pool.get_name} already exists"
    end
  end

  def add_machine(machine)
    unless @machines[machine.get_name] 
      @machines[machine.get_name] = machine
    else
      puts "A machine name #{machine.get_name} already exists"
    end
  end

  def name(name)
    @name = name
  end

  def monitor(pool_name, **opts)
    @pools[pool_name].add_observer(@machines[opts[:with]])
  end

  def set_backend(backend)
    if BACKENDS.index backend then
      options[:backend] = backend
    else
      puts "The backend #{backend} is not supported."
    end
  end



  def create(build_class, &block)
    instance = build_class.new
    if [Pool, Computer].index build_class then
      instance.instance_eval(&block)
      if build_class == Pool then
        Simulation.app.add_pool instance
      else
        Simulation.app.add_machine instance
      end
    else
      puts "The creation of #{build_class} is not supported"
    end
  end
end
