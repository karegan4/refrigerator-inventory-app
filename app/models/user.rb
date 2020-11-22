class User <ActiveRecord::Base
    validates_presence_of :username, :email, :password
    has_many :foods
    has_many :list_items
end