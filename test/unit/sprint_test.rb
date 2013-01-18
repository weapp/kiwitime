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

require 'test_helper'

class SprintTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
