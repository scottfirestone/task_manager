require 'yaml/store'

class TaskManagerApp < Sinatra::Base

  get '/' do
    erb :dashboard
  end

  get '/tasks' do
    @tasks = task_manager.all
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  get '/tasks/:id' do |id|
    @task = task_manager.find(id.to_i)
    erb :show
  end

  put '/tasks/:id' do |id|
    task_manager.update(id.to_i, params[:task])
    redirect "/tasks/#{id}"
  end

  get '/tasks/:id/edit' do |id|
    @task = task_manager.find(id.to_i)
    erb :edit
  end

  post "/tasks/:id" do |id|
    @task = task_manager.update(params[:task], id)
    redirect "/tasks"
  end

  post "/tasks" do
    task_manager.create(params[:task])
    redirect '/tasks'
  end

  delete "/tasks/:id" do |id|
    task_manager.delete(id.to_i)
    redirect "/tasks"
  end

  not_found do
    erb :error
  end

  def task_manager
    if ENV["RACK_ENV"] == "test"
      database = YAML::Store.new('db/task_manager_test')
    else
      database = YAML::Store.new('db/task_manager')
    end
    @task_manager ||= TaskManager.new(database)
  end

end
