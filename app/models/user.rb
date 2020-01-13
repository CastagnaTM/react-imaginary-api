class User < ApplicationRecord
    has_many :friendships
    validates :user_name, uniqueness: true
    validates :password, presence: true
end
