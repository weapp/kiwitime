# == Schema Information
#
# Table name: sprints
#
#  id         :integer          not null, primary key
#  init       :date
#  finish     :date
#  notas      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sprint < ActiveRecord::Base
  attr_accessible :finish, :init, :notas
  has_many :tasks

  scope :current_sprint, lambda {where('sprints.init < ?', Time.now ).where( 'sprints.finish > ?', Time.now)}

  def to_s
  	"#{init} - #{finish}"
  end

  def self.current
  	Sprint.current_sprint.first
  end
end
