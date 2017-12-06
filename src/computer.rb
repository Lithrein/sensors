require 'influxdb'

class Computer
  def initialize(name: "", database: "", user: "", password: "")
    @database = database
    @user = user
    @password = password

#    @lease = InfluxDB::Client.new(database: @database, user: @user, password: @password)
  end

  def name(name)
    @name = name
  end

  def get_name
    @name
  end

  def database(database)
    @database = database
  end

  def get_database
    @database
  end

  def user(user)
    @user = user
  end

  def get_user
    @user
  end

  def password(password)
    @password = password
  end

  def get_password
    @password
  end
  
  def update(captors)
    unless @lease
      @lease = InfluxDB::Client.new(database: @database, user: @user, password: @password)
    end
    
    Thread.new {
      captors.each do |c|
        data = { values: { value: "#{c.state}" },
                 tags:   { id: "#{c.id}" }
               }
        @lease.write_point('sensor', data)
      end
    }
  end
end
