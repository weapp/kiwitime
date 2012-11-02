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
end
