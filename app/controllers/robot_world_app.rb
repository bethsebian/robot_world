require 'models/robot_manager'

class RobotWorldApp <Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true
  
  get '/' do
    @robots = RobotManager.all
    erb :dashboard
  end

  get '/robots' do
    @robots = RobotManager.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    RobotManager.create(params[:robot])
    redirect '/'
  end

  # read
  get '/robots/:id' do |id|
    @robot = RobotManager.find(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robot = RobotManager.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id|
    RobotManager.update(id.to_i,params[:robot])
    redirect "robots/#{id}"
  end
end

# require 'models/task_manager'
#
# class TaskManagerApp < Sinatra::Base
#   set :root, File.expand_path("..", __dir__)
#   set :method_override, true
#
#   get '/' do
#     erb :dashboard
#   end
#
#   # read
#   get '/tasks' do
#     @tasks = TaskManager.all
#     erb :index
#   end
#
#   # create (first half)
#   get '/tasks/new' do
#     erb :new
#   end
#
#   # create (second half)
#   post '/tasks' do
#     TaskManager.create(params[:task])
#     redirect '/tasks'
#     # "<p>Params: #{params}</p> <p>Task params: #{params[:task]}</p>"
#   end
#
#   # read
#   get '/tasks/:id' do |id|
#     @task = TaskManager.find(id.to_i)
#     erb :show
#   end
#
#   get '/tasks/:id/edit' do |id|
#     @task = TaskManager.find(id.to_i)
#     erb :edit
#   end
#
#   put '/tasks/:id' do |id|
#     TaskManager.update(id.to_i,params[:task])
#     redirect "tasks/#{id}"
#   end
#
#   delete '/tasks/:id' do |id|
#     TaskManager.delete(id.to_i)
#     redirect '/tasks'
#   end
#
#   not_found do
#     erb :error
#   end
# end