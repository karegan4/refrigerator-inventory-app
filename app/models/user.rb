class User <ActiveRecord::Base
    validates_presence_of :username, :email, :password
    has_many :foods
end