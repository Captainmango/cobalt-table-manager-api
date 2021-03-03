class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :diners
      t.string :time
      t.integer :rating
      t.belongs_to :restaurant
      t.belongs_to :user
      t.timestamps
    end
  end
end
