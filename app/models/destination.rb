require 'open-uri'
require 'json'

class Destination < ApplicationRecord
  belongs_to :trip
  has_many :votes, dependent: :destroy
  validates :city, presence: true

  def all_trip_destinations
    trip = self.trip
    destinations = Destination.all.where(trip: trip)
  end
  
  def picture
  	city = self.city
  	api = "https://api.teleport.org/api/urban_areas/slug:#{city.split(",").first.downcase}/images/"
    api_result = JSON.parse(open(api).read)

    return api_result["photos"][0]["image"]["web"]
  end

end


            # <% api = "https://api.teleport.org/api/urban_areas/slug:#{destination.city.split(",").first.downcase}/images/" %>
            # <% api_result = JSON.parse(open(api).read) %>
            # <%= image_tag(api_result["photos"][0]["image"]["mobile"]) %>

