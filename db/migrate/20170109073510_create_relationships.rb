class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :user_one
      t.integer :user_two

      t.timestamps
    end
  end
end
