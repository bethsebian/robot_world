require File.expand_path('../config/environment',__FILE__)

run RobotWorldApp



# Create your own Sinatra app from scratch.
# This app should be a directory of robots.
#
# A robot has a
#   name,
#   city,
#   state,
#   avatar,
#   birthdate,
#   date hired, and
#   department.
#
# Program the CRUD functionality for robots so that we can
#   see all robots, YES
#   see one specific robot, YES
#   edit/update a robot, YES
#   create a robot, and YES
#   delete a robot. YES
#
# Use http://robohash.org/ for pictures.
#
# Add a dashboard that shows statistical data: average robot age, a breakdown of how many robots were hired each year, and number of robots in each department/city/state.