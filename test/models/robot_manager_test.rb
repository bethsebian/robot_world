require_relative '../test_helper'

class RobotManagerTest < Minitest::Test
  def create_robots(num)
    num.times do |i|
      RobotManager.create({ "id"          => "#{i+1} id",
                            "name"        => "#{i+1} name",
                            "city"        => "#{i+1} city",
                            "state"       => "#{i+1} state",
                            "avatar"      => "#{i+1} avatar",
                            "birthdate"   => "#{i+1} birthdate",
                            "date_hired"  => "#{i+1} date_hired",
                            "department"  => "#{i+1} department"
                          })
    end
  end

  def test_it_creates_a_robot
    create_robots(1)
    robot = RobotManager.all.last

    assert_equal "#{robot.id} name", robot.name
    assert_equal "#{robot.id} birthdate", robot.birthdate
    assert_equal RobotManager.all.first.id, robot.id
  end

  def test_it_finds_all_robots
    create_robots(2)

    assert_equal 2, RobotManager.all.count
  end

  def test_it_finds_a_robot_by_id
    create_robots(2)

    assert_equal "1 name", RobotManager.find(RobotManager.all.first.id).name
  end

  def test_it_updates_a_robot
    create_robots(1)

    RobotManager.update(RobotManager.all.first.id, {name: "new name", birthdate: "new birthdate"})

    robot = RobotManager.find(RobotManager.all.first.id)

    assert_equal "new name", robot.name
    assert_equal "new birthdate", robot.birthdate
  end

  def test_it_deletes_a_robot
    create_robots(3)
    total = RobotManager.all.count

    RobotManager.delete(RobotManager.all.first.id)

    assert_equal (total - 1), RobotManager.all.count
  end
end