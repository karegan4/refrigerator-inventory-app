class User < ActiveRecord::Base
    has_many :foods
    has_many :list_items
    validates_presence_of :username, :email
    validates :username, uniqueness: true
    has_secure_password

end