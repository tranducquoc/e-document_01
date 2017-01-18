class CreateCoins < ActiveRecord::Migration[5.0]
  def change
    create_table :coins do |t|
      t.string :code
      t.integer :value
      t.integer :user_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
