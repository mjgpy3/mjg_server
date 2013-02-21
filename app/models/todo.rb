class Todo < ActiveRecord::Base
  attr_accessible :color, :completed, :description
end
