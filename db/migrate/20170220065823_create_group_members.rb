class CreateGroupMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :group_members do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :group_type, default: 1
      t.integer :role, default: 0
      t.boolean :confirm, default: false

      t.timestamps
    end
  end
end
