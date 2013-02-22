class Todo < ActiveRecord::Base
  attr_accessible :color, :completed, :description, :admin_id
  belongs_to :admin
end
