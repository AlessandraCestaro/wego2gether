class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_trips, dependent: :destroy
  has_many :trips, through: :user_trips
  has_many :managed_trips, foreign_key: "user_id", class_name: "Trip"
  has_many :votes, dependent: :destroy

end
