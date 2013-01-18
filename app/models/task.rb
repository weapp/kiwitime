# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  time_scope  :integer
#  project_id  :integer
#  finished    :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  position    :integer
#  sprint_id   :integer
#

class Task < ActiveRecord::Base
  acts_as_list

  attr_accessible :description, :finished, :name, :project_id, :time_scope, :sprint_id

  belongs_to :project
  belongs_to :sprint

  has_many :sittings, dependent: :destroy
  has_many :users,  :through => :sittings


  validates :project_id, presence: true

  default_scope :order => 'tasks.position ASC'

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
    finished && (sittings.collect{|s| s.day}.max || updated_at.to_date)
  end
end
