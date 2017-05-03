class User < ActiveRecord::Base
    has_many :likes
    has_many :posts, :through => :likes
end
