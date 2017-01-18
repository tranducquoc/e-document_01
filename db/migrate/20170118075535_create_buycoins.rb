class CreateBuycoins < ActiveRecord::Migration[5.0]
  def change
    create_table :buycoins do |t|
      t.integer :user_id
      t.integer :coin_id

      t.timestamps
    end
  end
end
