class WorkingsController < ApplicationController
  load_and_authorize_resource :sprint
  load_and_authorize_resource :working, :through => :sprint

  # GET /workings
  # GET /workings.json
  def index
    @workings = Working.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workings }
    end
  end

  # GET /workings/1
  # GET /workings/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @working }
    end
  end

  # GET /workings/new
  # GET /workings/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @working }
    end
  end

  # GET /workings/1/edit
  def edit
  end

  # POST /workings
  # POST /workings.json
  def create
    respond_to do |format|
      if @working.save
        format.html { redirect_to sprints_path, notice: 'Working was successfully created.' }
        format.json { render json: @working, status: :created, location: @working }
      else
        format.html { render action: "new" }
        format.json { render json: @working.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workings/1
  # PUT /workings/1.json
  def update
    respond_to do |format|
      if @working.update_attributes(params[:working])
        format.html { redirect_to @working, notice: 'Working was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @working.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workings/1
  # DELETE /workings/1.json
  def destroy
    @working.destroy

    respond_to do |format|
      format.html { redirect_to sprints_path }
      format.json { head :no_content }
    end
  end
end
