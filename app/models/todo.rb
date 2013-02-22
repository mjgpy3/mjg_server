class Todo < ActiveRecord::Base
  attr_accessible :color, :completed, :description
  belongs_to :admin
end
