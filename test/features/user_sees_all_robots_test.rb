require_relative '../test_helper'

class UserSeesAllRobotsTest < FeatureTest

  def create_robots(num)
    num.times do |i|
      RobotManager.create({ "name"       => "#{i+1} name",
                            "city"       => "#{i+1} city",
                            "state"      => "#{i+1} state",
                            "avatar"     => "#{i+1} avatar",
                            "birthdate"  => "#{i+1} birthdate",
                            "date_hired" => "#{i+1} date_hired",
                            "department" => "#{i+1} department"
                          })
    end
  end

  def test_new_robot_creation
    visit("/")
    click_link("New Robot")

    fill_in("robot[name]", with: "new robot")
    fill_in("robot[city]", with: "new city")
    fill_in("robot[state]", with: "new state")
    fill_in("robot[avatar]", with: "new avatar")
    fill_in("robot[birthdate]", with: "new birthdate")
    fill_in("robot[date_hired]", with: "new date_hired")
    fill_in("robot[department]", with: "new department")

    assert_equal "/robots/new", current_path

    click_button("submit")

    assert_equal "/robots", current_path

    within("//div[@id='index-container']") do
      assert page.has_content?("new robot")
    end
  end

  def test_user_can_edit_a_robot
    create_robots(1)
    robot = RobotManager.all.last

    visit "/robots"
    click_link("Edit")
    fill_in("robot[name]", with: "new robot edited")
    fill_in("robot[birthdate]", with: "new birthdate edited")
    click_button("submit")

    assert_equal "/robots/#{robot.id}", current_path
    within(".container") do
      assert page.has_content?("new robot edited")
    end
  end

  def test_user_can_delete_a_robot
    create_robots(1)

    visit "/robots"

    click_button("delete")

    refute page.has_content?("new robot")
  end

  def test_a_user_can_see_a_single_robot
    create_robots(1)
    robot = RobotManager.all.last

    visit "/robots"

    click_link("1 name")
    assert_equal "/robots/#{robot.id}", current_path
    assert page.has_content?("1 birthdate")
  end

  def test_filter_robot_index_by_param
    skip
    create_robots(2)
    RobotManager.create({"name"       => "dogsitting",
                         "birthdate" => "Friday"})
    RobotManager.create({ "name"      => "dogsitting",
                         "birthdate" => "Saturday"})

    visit "/robots?name=dogsitting"

    selected_robots = RobotManager.all.select { |robot| robot.name == "dogsitting"}

    selected_robots.each do |robot|
      within(".robot-#{robot.id}") do
        assert page.has_content?("dogsitting")
      end
    end
    save_and_open_page
    refute page.has_content?("1 name")
    refute page.has_content?("2 name")
  end
end
