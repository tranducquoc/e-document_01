class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :description
      t.string  :attachment
      t.integer :status, default: 0
      t.integer :category_id
      t.integer :user_id
      t.integer :view, default: 0
      t.integer :status_upload, default:0
      t.timestamps
    end
  end
end
