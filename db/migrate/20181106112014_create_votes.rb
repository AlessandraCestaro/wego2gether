class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :destination, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
