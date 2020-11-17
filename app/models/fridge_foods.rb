class FridgeFoods < ActiveRecord::Base
    validates_presence_of :food, :quantity
end