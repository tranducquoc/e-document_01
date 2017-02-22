class CreateShares < ActiveRecord::Migration[5.0]
  def change
    create_table :shares do |t|
      t.integer :user_id
      t.integer :document_id

      t.timestamps
    end
  end
end
