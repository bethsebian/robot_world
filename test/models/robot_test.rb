require_relative '../test_helper'

class RobotTest < Minitest::Test
  def test_attributes_are_assigned_correctly
    robot = Robot.new({ :id          => "1",
                        :name        => "RoboCop",
                        :city        => "Denver",
                        :state       => "CO",
                        :avatar      => "turing.io",
                        :birthdate   => "May 2, 2004",
                        :date_hired  => "November 12, 2013",
                        :department  => "swimming"})

    assert_equal "1", robot.id
    assert_equal "RoboCop", robot.name
    assert_equal "Denver", robot.city
  end
end