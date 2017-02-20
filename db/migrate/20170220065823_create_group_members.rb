class CreateGroupMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :group_members do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :group_type
      t.string :role
      t.binary :confirm

      t.timestamps
    end
  end
end
