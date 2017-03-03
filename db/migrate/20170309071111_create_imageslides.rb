class CreateImageslides < ActiveRecord::Migration[5.0]
  def change
    create_table :imageslides do |t|
      t.string  :image
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
