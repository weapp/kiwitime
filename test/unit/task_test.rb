# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
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

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
