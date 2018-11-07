class Trip < ApplicationRecord
  belongs_to :user
  has_many :user_trips, dependent: :destroy
  has_many :users, through: :user_trips
  has_many :destinations, dependent: :destroy
  validates :name, :deadline_date, presence: true
end
