class CommentsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :task, :through => :project
  load_and_authorize_resource :comment, :through => :task

  # GET project/tasks/1/comments
  # GET project/tasks/1/comments.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @comments }
    end
  end

  # GET project/tasks/1/comments/1
  # GET project/tasks/1/comments/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @comment }
    end
  end

  # GET project/tasks/1/comments/new
  # GET project/tasks/1/comments/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @comment }
    end
  end

  # GET project/tasks/1/comments/1/edit
  def edit
  end

  # POST project/tasks/1/comments
  # POST project/tasks/1/comments.json
  def create
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to([@project, @task], :notice => 'Comment was successfully created.') }
        format.json { render :json => @comment, :status => :created, :location => [@comment.project_task, @comment] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT project/tasks/1/comments/1
  # PUT project/tasks/1/comments/1.json
  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to([@comment.project_task, @comment], :notice => 'Comment was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE project/tasks/1/comments/1
  # DELETE project/tasks/1/comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
    end
  end
end
