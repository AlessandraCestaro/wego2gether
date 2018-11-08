class UpdateStateOfExistingUserTrips < ActiveRecord::Migration[5.2]
  def change
    change_column_default :user_trips, :state, from: nil, to: "pending"
  end
end
