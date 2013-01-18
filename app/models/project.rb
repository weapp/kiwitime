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
    @points_finished ||= (tasks.collect{|t| t.finished ? (t.points||0) : 0 }).sum()
  end

  def total_points
    @total_points ||= (tasks.collect{|t| t.points||0}).sum()
  end
end
