class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.reference :attraction_id
      t.reference :user_id

      t.timestamps
    end
  end
end
