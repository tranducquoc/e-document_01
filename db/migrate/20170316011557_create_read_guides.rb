class CreateReadGuides < ActiveRecord::Migration[5.0]
  def change
    create_table :read_guides do |t|
      t.integer :Organization_id
      t.integer :User_id
      t.integer :read, default: 0

      t.timestamps
    end
  end
end
