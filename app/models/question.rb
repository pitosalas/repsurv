class Question < ActiveRecord::Base
  attr_accessible :text, :order, :data_type, :active
end
