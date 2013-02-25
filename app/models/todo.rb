class Todo < ActiveRecord::Base
  attr_accessible :color, :completed, :description, :user_id
  belongs_to :user
end
