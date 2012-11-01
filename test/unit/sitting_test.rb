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

require 'test_helper'

class SittingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
