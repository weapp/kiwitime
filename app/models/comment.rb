class Comment < ActiveRecord::Base
  attr_accessible :end, :start, :task_id, :user_id, :day, :message

  belongs_to :task
  belongs_to :project
  belongs_to :user

  validates :user_id, presence: true
  validates :task_id, presence: true

  default_scope :order => 'comments.created_at DESC'
end
