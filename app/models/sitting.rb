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
#

class Sitting < ActiveRecord::Base
  attr_accessible :end, :start, :task_id, :user_id, :day

  belongs_to :task
  belongs_to :user

  def end_min
    self.end.hour * 60 + self.end.min
  end

  def start_min
    start.hour * 60 + start.min
  end
  
  def delta
    if end_min == 0 
      0
    else
      end_min - start_min
    end
  end
end
