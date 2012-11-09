# == Schema Information
#
# Table name: sittings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  task_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  day        :date
#  start      :time
#  end        :time
#  message    :string(255)
#

class Sitting < ActiveRecord::Base
  attr_accessible :end, :start, :task_id, :user_id, :day

  belongs_to :task
  belongs_to :user

  validates :user_id, presence: true
  validates :task_id, presence: true

  default_scope :order => 'sittings.created_at DESC'

  def end_min
    if self.end.nil? then 0 else self.end.hour * 60 + self.end.min end
  end

  def start_min
    if self.start.nil? then 0 else start.hour * 60 + start.min end
  end


  def in_progress?
    self.end.nil? || end_min == 0
  end
  
  def delta
    if end_min == 0 
      0
    else
      r = end_min - start_min
      #previene errores cuando hay un sitting a media noche
      r += (24 * 60) if r < 0 
      r
    end
  end
end
