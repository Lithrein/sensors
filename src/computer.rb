require 'influxdb'

class Computer
  def initialize(database: "", user: "", password: "")
    @database = database
    @user = user
    @password = password

    @lease = InfluxDB::Client.new(database: @database, user: @user, password: @password)
  end

  def update(captors)
    Thread.new {
      puts "bli"
      captors.each { |c| @lease.write_point("sensor", {values: {value: c.state},
                                                       tags: {id: "#{c.id}"}}) }
    }
  end
end
