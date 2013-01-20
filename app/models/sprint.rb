# == Schema Information
#
# Table name: sprints
#
#  id         :integer          not null, primary key
#  init       :date
#  finish     :date
#  notas      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sprint < ActiveRecord::Base
  attr_accessible :finish, :init, :notas
  has_many :tasks

  scope :current_sprint, lambda {where('sprints.init < ?', Time.now ).where( 'sprints.finish > ?', Time.now)}

  def to_s
  	"#{init} - #{finish}"
  end

  def self.current
  	@current ||= Sprint.current_sprint.first
  end

  def total_points
    @total_points ||= (tasks.collect{|t| t.points||0}).sum
  end

  def chart
    return @chart if @chart
    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers 
    data_table.new_column('string', 'Day' ) 
    data_table.new_column('number', 'Actual') 
    data_table.new_column('number', 'Scope')
    data = (init..finish).collect do |d|
      [
        d.to_s(:short),
        (Time.now >= d) ? (total_points - tasks.select{|t| t.finished_at d }.collect{|t| t.points}.sum) : nil,
        (total_points * (finish - d) / days),
      ]
    end

    
    if data[0][1].present?
      # Add Rows and Values 
      data_table.add_rows(data)
      option = { width: 800, height: 400, title: to_s, legend: {position: "none"} }
      @chart = GoogleVisualr::Interactive::LineChart.new(data_table, option)
    end
  end

  def days
  	finish - init
  end

end
