class User < ApplicationRecord
	has_many :articles
	has_secure_password

	validates :email, presence: true, format: {with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid Email Address"}
end
