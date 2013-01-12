# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :name
  has_many :tasks, dependent: :destroy

  def delta
    tasks.sum{|task| task.delta}
  end

  def serializable_hash(options={})
    options = { 
      include: {
        tasks: {
          sittings: {
            user: {}
          }
        }
      }
    }.update(options)
    super(options)
  end
end
