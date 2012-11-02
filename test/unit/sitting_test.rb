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

require 'test_helper'

class SittingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
