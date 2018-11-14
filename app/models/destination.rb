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

    url = begin
      api_result = JSON.parse(open(api).read)
      api_result["photos"][0]["image"]["web"]
    rescue Exception => e
      self.default_picture
    end

    url
  end

  def picture_mobile
    city = self.city
    api = "https://api.teleport.org/api/urban_areas/slug:#{city.split(",").first.downcase}/images/"

    url = begin
      api_result = JSON.parse(open(api).read)
      api_result["photos"][0]["image"]["mobile"]
    rescue Exception => e
      self.default_picture
    end

    url
  end

  def default_picture
    "https://unsplash.com/photos/aHu_xuRvsZ4"
  end

end


            # <% api = "https://api.teleport.org/api/urban_areas/slug:#{destination.city.split(",").first.downcase}/images/" %>
            # <% api_result = JSON.parse(open(api).read) %>
            # <%= image_tag(api_result["photos"][0]["image"]["mobile"]) %>

