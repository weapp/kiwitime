# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name
  resourcify

  attr_accessible :name
  has_many :tasks, dependent: :destroy

  def delta
    tasks.sum{|task| task.delta}
  end

  def serializable_hash(options={})
    options = { 
      include: {
        tasks: {
          sittings: {
            user: {}
          }
        }
      }
    }.update(options)
    super(options)
  end

  def to_s
    name.humanize
  end

  def points_finished
    @points_finished ||= (tasks.collect{|t| t.finished ? (t.points||0) : 0 }).sum
  end

  def total_points
    @total_points ||= (tasks.collect{|t| t.points||0}).sum
  end

  def total_points_by_sprint(sprint)
    (tasks.by_sprint(sprint).collect{|t| t.points||0}).sum
  end

  def current_total_points
    @current_total_points ||= total_points_by_sprint(Sprint.current)
  end

  def stats(sprint)
    if sprint
      tp = total_points_by_sprint(sprint)
      workings_days = sprint.workings
      days = workings_days.count
      n = 0
      (workings_days).collect do |w|
        n += 1
        d = w.day
        [
          d.strftime("%a, %d %b"),
          (Time.now >= d) ? (tp - tasks.select{|t| t.finished_at d }.collect{|t| t.points || 0}.sum) : nil,
          (tp * (days - n) / (days)).to_f,
        ]
      end
    end
  end


end
