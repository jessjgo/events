class User < ActiveRecord::Base
	has_secure_password

	has_many :events
	has_many :comments
	has_many :attendees
	has_many :events_they_have_commented_on, through: :comments, source: :event
	has_many :events_they_are_attending, through: :attendees, source: :event

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :fname, :lname, :email, :location, presence: true
	validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
	validates :password, length: {minimum: 8}, presence: true, on: :create
	validates_confirmation_of :password, allow_blank: true
	validates :state, length: {is: 2}
end