class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :destination
  validates :rating, presence: :true
  validates :rating, inclusion: { in: (0..5)}
end
