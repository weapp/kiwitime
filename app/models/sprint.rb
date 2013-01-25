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
  has_many :workings

  scope :current_sprint, lambda {where('sprints.init < ?', Time.now ).where( 'sprints.finish > ?', Time.now)}

  def to_s
  	"#{init.to_s(:long)} - #{finish.to_s(:long)}"
  end

  def self.current
  	Sprint.current_sprint.first
  end

  def total_task_points
    (tasks.collect{|t| t.points||0}).sum
  end

  def total_working_points
    (workings.collect{|w| w.points||0}).sum
  end

  def stats
    sum_p = 0
  	@stats ||= (workings).collect do |w|
      d = w.day
      p = w.points || 0
      sum_p += p
      [
        d.strftime("%a, %d %b"),
        (Time.now >= d) ? (total_working_points - tasks.select{|t| t.finished_at d }.collect{|t| t.points || 0}.sum) : nil,
        total_working_points - sum_p,
      ]
  	end
  end

  def chart
    if stats[0][1].present?
      data_table = GoogleVisualr::DataTable.new
      # Add Column Headers 
      data_table.new_column('string', 'Day' ) 
      data_table.new_column('number', 'Actual') 
      data_table.new_column('number', 'Scope')
      # Add Rows and Values 
      data_table.add_rows(stats)
      option = { width: 800, height: 400, title: to_s, legend: {position: "none"} }
      @chart = GoogleVisualr::Interactive::LineChart.new(data_table, option)
    end
  end

  def days
  	finish - init
  end

  def workings_days
    workings.collect {|w| w.day}
  end

end
