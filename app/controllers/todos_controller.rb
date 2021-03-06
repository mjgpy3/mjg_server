class TodosController < ApplicationController

  before_filter :authenticate_user!

  # GET /todos
  # GET /todos.json
  def index
    @todos = current_user.todos

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

    if current_user_owns_todo? @todo
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @todo }
      end
    else
      redirect_to(todos_path, :alert => "Not a valid action!")
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])

    if not current_user_owns_todo? @todo
      redirect_to(todos_path, :alert => "Not a valid action!")
    end
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(params[:todo])

    @todo.user_id = current_user.id

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])

    if current_user_owns_todo? @todo
      respond_to do |format|
        if @todo.update_attributes(params[:todo])
          format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @todo.errors, status: :unprocessable_entity }
       end
      end
    else
      redirect_to(todos_path, :alert => "Not a valid action!")
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])

    if current_user_owns_todo? @todo
      @todo.destroy
      respond_to do |format|
        format.html { redirect_to todos_url }
        format.json { head :no_content }
      end
    else
      redirect_to(todos_path, :alert => "Not a valid action!")
    end
  end

  # Sets the todo with id :todo_id to complete
  def complete
    @todo = Todo.find(params[:todo_id])

    if current_user_owns_todo? @todo
      @todo.completed = true
      @todo.save
      redirect_to(:back, :notice => "Set to complete")
    else
      redirect_to(todos_path, :alert => "Not a valid action!")
    end
  end

private

  def current_user_owns_todo?(todo)
    current_user.id == todo.user_id
  end

end
