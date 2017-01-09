class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :description
      t.integer :status
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
