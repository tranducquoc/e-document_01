class CreateShares < ActiveRecord::Migration[5.0]
  def change
    create_table :shares do |t|
      t.integer :share_id
      t.integer :share_type, default: 2
      t.integer :document_id

      t.timestamps
    end
  end
end
