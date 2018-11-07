class Destination < ApplicationRecord
  belongs_to :trip
  has_many :votes, dependent: :destroy
  validates :city, :country, presence: true
end
