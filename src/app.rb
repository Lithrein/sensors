# coding: utf-8
require './law'
require './pointcloud_law'
require './random_law'
require './pool'
require './sensor'
require './computer'

class App
  attr_accessor :name, :pools
  def initialize(name: nil, pools: [])
    @name = name
    @pools = pools
  end

  def run
    @pools.each { |p| p.run }
  end

  def add_pool(pool)
    @pools << pool
  end
  end
