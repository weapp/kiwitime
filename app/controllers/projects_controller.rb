class ProjectsController < ApplicationController
  load_and_authorize_resource
  load_and_authorize_resource :sprint, :only => :sprint

  respond_to :html, :json
  layout false, only: :report

  # GET /projects
  # GET /projects.json
  def index
    @projects = @projects.includes(:tasks).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show    
    @chart = current_chart
    respond_with(@project)
  end

  def sprint    
    @chart = chart(@sprint)
    #render :template => 'projects/show'
    respond_with(@project)
  end

  def chart(sprint)
    total_points = @project.total_points_by_sprint(sprint)
    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers 
    data_table.new_column('string', 'Day' ) 
    data_table.new_column('number', 'Actual') 
    data_table.new_column('number', 'Scope')
    data = (sprint.init..sprint.finish).collect do |d|
      [
        d.to_s(:short),
        (Time.now >= d) ? (total_points - @project.tasks.select{|t| t.finish_at && t.finish_at < d }.collect{|t| t.points}.sum) : nil,
        (total_points * (sprint.finish - d) / (sprint.finish - sprint.init)),
      ]
    end
    
    unless data[0][1].present?
      # Add Rows and Values 
      data_table.add_rows(data)
      option = { width: 800, height: 400, title: 'Company Performance', legend: {position: "none"} }
      GoogleVisualr::Interactive::LineChart.new(data_table, option)
    end
  end

  def current_chart
    chart(Sprint.current)
  end

  def report
    show
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
