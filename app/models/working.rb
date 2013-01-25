# == Schema Information
#
# Table name: workings
#
#  id         :integer          not null, primary key
#  sprint_id  :integer
#  day        :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Working < ActiveRecord::Base
  attr_accessible :day, :sprint_id, :points
  belongs_to :sprint
  default_scope :order => 'workings.day ASC'
end
