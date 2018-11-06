class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.references :trip, foreign_key: true
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
