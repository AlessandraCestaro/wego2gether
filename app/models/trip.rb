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
        users.push(user) unless self.invited_users_accepted.include?(self.users_voted)
      end
  end

end
