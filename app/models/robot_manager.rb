require 'yaml/store'
require_relative 'robot'

class RobotManager
  def self.database
    if ENV["RACK_ENV"] == "test"
      @database ||= Sequel.sqlite("db/robot_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/robot_manager_development.sqlite3")
    end
  end

  def self.create(robot)
    dataset.insert(robot)
  end

  def self.raw_robots
    database.transaction do
      database[:robots] || []
    end
  end

  def self.all
    raw_robots.map { |data| Robot.new(data)}
  end

  def self.raw_robot(id)
    raw_robots.find { |data| data[:id] == id }
  end

  def self.find(id)
    Robot.new(raw_robot(id))
  end

  def self.find_by(input)
    robots = database.from(:robots).where(input.keys.first => input.values.last)
    robots.map { |data| Robot.new(data) }
  end

  def self.update(id, data)
    dataset.where(:id => id).update(data)
  end

  def self.delete(id)
    dataset.where(:id=>id).delete
  end

  def self.delete_all
    database.transaction do
      database[:robots] = []
      database['total'] = 0
    end
  end

  def self.dataset
    database.from(:robots)
  end
end