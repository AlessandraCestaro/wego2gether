class Destination < ApplicationRecord
  belongs_to :trip
  has_many :votes, dependent: :destroy
end
