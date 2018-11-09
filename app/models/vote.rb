class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :destination
  validates :rating, presence: :true
  validates :rating, inclusion: { in: (0..5)}

  def all_votes_for_specific_destination
    # Remember a destination has a specific trip_id already embedded in it
    destination = self.destination
    votes = Vote.all.where(destination: destination)
  end

end
