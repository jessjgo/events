class Event < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :attendees
	has_many :users_commented_on_it, through: :comments, source: :user
	has_many :users_attending_it, through: :attendees, source: :user

	validates :name, :event_date, :location, :state, presence: true
	validates :state, length: {is: 2}
	validate :event_future_date

	def event_future_date
		# puts '*************************************'
		# puts event_date.class
		# puts event_date
		# puts Date.today
		errors.add(:event_date, "Cannot be in the past") if !event_date.blank? and event_date < Date.today

	end

end