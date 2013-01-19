# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  project_id  :integer
#  finished    :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  position    :integer
#  sprint_id   :integer
#  points      :float
#

class Task < ActiveRecord::Base
  acts_as_list

  attr_accessible :description, :finished, :name, :project_id, :points, :sprint_id

  belongs_to :project
  belongs_to :sprint

  has_many :sittings, dependent: :destroy
  has_many :users,  :through => :sittings


  validates :project_id, presence: true

  default_scope :order => 'tasks.position ASC'

  scope :icebox, lambda{ where(sprint_id: nil) }
  scope :by_sprint, lambda{|sprint| where(sprint_id: sprint.id)}
  scope :current, lambda{by_sprint Sprint.current}
  #(day && t.finish_at) ? ((t.finish_at < day) ? t.points : 0) : 0}.sum }

  def in_progress?
    sittings.any? { |sitting| sitting.in_progress? }
  end

  def in_progress_for_user?(user)
    sittings.any? { |sitting| sitting.in_progress? && sitting.user == user}
  end

  def delta
    sittings.sum{|sitting| sitting.delta}
  end

  def finish_at
    finished && (sittings.collect{|s| s.day}.select{|s| s}.max || updated_at.to_date)
  end

end
