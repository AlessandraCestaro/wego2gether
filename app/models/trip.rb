class Trip < ApplicationRecord
  belongs_to :user
  has_many :user_trips, dependent: :destroy
  has_many :users, through: :user_trips
  has_many :destinations, dependent: :destroy
  validates :name, :deadline_date, presence: true

  def invited_users_all
    user_ids = self.user_trips.map(&:user_id)
    User.where(id: user_ids)
  end

  def invited_users_accepted
    user_ids = self.user_trips.where(state: "accepted").map(&:user_id)
    User.where(id: user_ids)
  end

  def invited_users_pending
    user_ids = self.user_trips.where(state: "pending").map(&:user_id)
    User.where(id: user_ids)
  end

  def invited_users_declined
    user_ids = self.user_trips.where(state: "declined").map(&:user_id)
    User.where(id: user_ids)
  end

  def users_voted
    users = []
    self.destinations.each do |destination|
      destination.votes.each do |vote|
        if self.invited_users_accepted.include?(vote.user)
          users.push(vote.user) unless users.include?(vote.user)
        end
      end
    end
    users
  end

  def users_accepted_no_vote
    users = []
      self.invited_users_accepted.each do |user|
        users.push(user) unless self.users_voted.include?(user)
      end
    users
  end

# Returns an array with the sum of ratings for all destinations of a specific trip
  def all_trip_ratings
    array = []

    self.destinations.each do |destination|
      sum = 0
      destination.votes.each do |vote|
        sum += vote.rating
        array << sum
      end
    end
    array
  end

# Returns an integer, which is the sum of ratings for the destination(s) that received max ratings, for a specific trip
  def max_rating
    array = self.all_trip_ratings
    max_rating = array.max
  end

# Returns an array containing all destinations for a trip which achieved maximum rating (votes)
  def winning_destination
    winner = []
    self.destinations.each do |destination|
      sum = 0
      destination.votes.each do |vote|
        sum += vote.rating
        if sum >= self.max_rating
          winner << destination
        end
      end
    end
    winner
  end

# End of class
end
