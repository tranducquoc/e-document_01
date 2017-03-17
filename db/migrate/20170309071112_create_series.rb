class CreateSeries < ActiveRecord::Migration[5.0]
  def change
    create_table :series do |t|
      t.text :name
      t.references :user
      t.integer :organization_id

      t.timestamps
    end
  end
end
