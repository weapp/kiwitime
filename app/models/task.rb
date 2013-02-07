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
#  status      :string(255)
#  category    :string(255)      default("feature")
#

class Task < ActiveRecord::Base
  acts_as_list

  POINTS = [0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 8.0, 13.0, 20.0, 40.0]
  CATEGORIES = [ :feature, :bug, :chore, :release ]

  attr_accessible :id,:description, :finished, :name, :project_id, :points, :sprint_id, :category

  belongs_to :project
  belongs_to :sprint

  has_many :sittings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :users,  :through => :sittings


  validates :name, presence: true
  validates :project_id, presence: true
  validates :points, :inclusion => { :in => [nil, 0, 0.0, "0"]}, :if => :no_puntuable

  default_scope :order => 'tasks.position ASC'

  scope :icebox, lambda{ where(sprint_id: nil) }
  scope :by_sprint_id, lambda{|sprint_id| where(sprint_id: sprint_id)}
  scope :by_sprint, lambda{|sprint| sprint ? by_sprint_id(sprint.id) : where(0)}
  scope :current, lambda{by_sprint Sprint.current}
  #(day && t.finish_at) ? ((t.finish_at < day) ? t.points : 0) : 0}.sum }

  after_update :move_to_bottom_if_sprint_is_changed

  def move_to_bottom_if_sprint_is_changed
    # comprobamos que no sea el ultimo para no provocar un bucle infinito
    if sprint_id_changed? && Task.last != self && !position_changed?
      move_to_bottom
    end
  end
  

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

  def finished_at(day)
    finish_at && finish_at <= day
  end

  def no_puntuable
    ["chore", "bug", "release"].include?(category)
  end
end
