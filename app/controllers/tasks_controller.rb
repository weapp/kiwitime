class TasksController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :task, :through => :project

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  def sort
    @tasks = Task.all
    @tasks.each do |task|
      index = params['task'].index(task.id.to_s)
      if index
        task.position = params['task'].index(task.id.to_s) + 1
        task.save
      end 
    end

    render :nothing => true
  end


  # GET /tasks/1
  # GET /tasks/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    respond_to do |format|
      if @task.save
        format.html { redirect_to [@project], notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to :back, notice: 'Task was successfully updated.'}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to project_tasks_url }
      format.json { head :no_content }
    end
  end

  def finish
    @task.finished = true
    @task.save
    @task.sittings.each do |sitting| 
      if sitting.in_progress?
        sitting.end = Time.now
        sitting.save
      end
    end
    redirect_to :back, notice: 'Task stopped and finished.'
  end

  def reopen
    @task.finished = false
    @task.save
    redirect_to :back, notice: 'Task is re-openend'
  end

  def up
    @task.sprint = Sprint.current
    @task.save
    redirect_to :back, notice: 'Task is up to sprint!'
  end

  def accept
    @task.status = "accept"
    @task.save
    redirect_to :back, notice: 'Task is Accepted!'
  end

  def start
    #@task = Task.find(params[:id])
    #p = {"task_id"=>params[:id], "day(1i)"=>"2012", "day(2i)"=>"11", "day(3i)"=>"6", "start(1i)"=>"2012", "start(2i)"=>"11", "start(3i)"=>"6", "start(4i)"=>"20", "start(5i)"=>"36", "end(1i)"=>"1", "end(2i)"=>"1", "end(3i)"=>"1", "end(4i)"=>"", "end(5i)"=>""}
    p = {"task_id"=>params[:id], day: Time.now, start:Time.now}
    sitting = current_user.sittings.build({task_id: params[:id], start: Time.now, day: Time.now})
    sitting.save
    redirect_to :back, notice: 'Task started.'
  end

  def stop
    @task.sittings.each do |sitting| 
      if sitting.user == current_user && sitting.in_progress?
        sitting.end = Time.now
        sitting.message = params[:message]
        sitting.save
      end
    end
    @task.save
    redirect_to :back, notice: 'Task stopped.'
  end
end
