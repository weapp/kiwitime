# == Schema Information
#
# Table name: sittings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  task_id    :integer
#  start      :datetime
#  end        :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sitting < ActiveRecord::Base
  attr_accessible :end, :start, :task_id, :user_id

  belongs_to :task
  belongs_to :user
end
