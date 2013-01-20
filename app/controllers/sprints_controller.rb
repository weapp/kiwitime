class SprintsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  # GET /sprints
  # GET /sprints.json
  def index
    respond_with(@sprints)
  end

  # GET /sprints/1
  # GET /sprints/1.json
  def show
    respond_with(@sprint)
  end

  # GET /sprints/new
  # GET /sprints/new.json
  def new
    respond_with(@sprint)
  end

  # GET /sprints/1/edit
  def edit
  end

  # POST /sprints
  # POST /sprints.json
  def create
    respond_to do |format|
      if @sprint.save
        format.html { redirect_to @sprint, notice: 'Sprint was successfully created.' }
        format.json { render json: @sprint, status: :created, location: @sprint }
      else
        format.html { render action: "new" }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sprints/1
  # PUT /sprints/1.json
  def update
    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        format.html { redirect_to @sprint, notice: 'Sprint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sprints/1
  # DELETE /sprints/1.json
  def destroy
    @sprint.destroy

    respond_to do |format|
      format.html { redirect_to sprints_url }
      format.json { head :no_content }
    end
  end




end
