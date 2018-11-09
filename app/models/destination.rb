class Destination < ApplicationRecord
  belongs_to :trip
  has_many :votes, dependent: :destroy
  validates :city, :country, presence: true

  def all_trip_destinations
    trip = self.trip
    destinations = Destination.all.where(trip: trip)
  end

end

