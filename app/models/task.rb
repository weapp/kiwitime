# == Schema Information
#
# Table name: tasks
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :string(255)
#  time_forecast :integer
#  project_id    :integer
#  finished      :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Task < ActiveRecord::Base
  attr_accessible :description, :finished, :name, :project_id, :time_forecast

  has_many :sittings
  belongs_to :project
end
