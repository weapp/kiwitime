class SittingsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :task, :through => :project
  load_and_authorize_resource :sitting, :through => :task


  # GET /sittings
  # GET /sittings.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sittings }
    end
  end

  # GET /sittings/1
  # GET /sittings/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sitting }
    end
  end

  # GET /sittings/new
  # GET /sittings/new.json
  def new
    @sitting.user = current_user
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sitting }
    end
  end

  # GET /sittings/1/edit
  def edit
  end

  # POST /sittings
  # POST /sittings.json
  def create
    respond_to do |format|
      if @sitting.save
        format.html { redirect_to [@project, @task], notice: 'Sitting was successfully created.' }
        format.json { render json: @sitting, status: :created, location: @sitting }
      else
        format.html { render action: "new" }
        format.json { render json: @sitting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sittings/1
  # PUT /sittings/1.json
  def update
    respond_to do |format|
      if @sitting.update_attributes(params[:sitting])
        format.html { redirect_to [@project, @task], notice: 'Sitting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sitting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sittings/1
  # DELETE /sittings/1.json
  def destroy
    @sitting.destroy

    respond_to do |format|
      format.html { redirect_to project_task_sittings_url }
      format.json { head :no_content }
    end
  end
end
