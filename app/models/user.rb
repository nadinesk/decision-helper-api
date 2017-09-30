class User < ApplicationRecord

	has_many :decisions

	validates :username, presence: true
	validates :username, uniqueness: true

end
