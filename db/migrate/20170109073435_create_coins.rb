class CreateCoins < ActiveRecord::Migration[5.0]
  def change
    create_table :coins do |t|
      t.string :code
      t.integer :value
      t.integer :buyer_id
      t.integer :used_id

      t.timestamps
    end
  end
end
