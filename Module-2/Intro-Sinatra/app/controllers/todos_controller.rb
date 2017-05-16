class TodosController < Sinatra::Base
  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  # sets the view directory correctly
  # set :views, Proc.new { File.join(root, "views") }
  get "/" do
    @todos = Todo.all
    erb :'todos/index'
  end

  get "/todos/:id" do
    # binding.pry
    todo_id = params[:id].to_i
    if Todo.pluck(:id).include?(todo_id)
      @todo = Todo.find(todo_id)
      erb :'todos/show'
    else
      redirect '/'
    end
  end

end
