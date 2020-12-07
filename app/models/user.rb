class User < ActiveRecord::Base
    has_many :foods
    has_many :list_items
    validates_presence_of :username, :email
    has_secure_password

end