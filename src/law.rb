class Model
  attr_reader :attributes

  def initialize
    @attributes = {}
  end
  
  def method_missing(name, args, &block)
    @attributes[name] = args
  end
end

module Law
  @klasses = {}
  
  def self.define(name, &block)
    model = Model.new
    model.instance_eval(&block)
    builder = Class.new do
      @@attributes = []

      attrs = model.attributes
      attrs.each do |attr, val|
        if val.is_a?(Proc) then
          define_method(attr, val)
        else
          attr_accessor val
          @@attributes << val
        end
      end

      def initialize(*args)
        @@attributes[0..args.size-1].zip(args) do |attr, val|
          send "#{attr}=", val
        end
      end
    end
    klass = Object.const_set name, builder
    @klasses[name] = klass
  end
end
