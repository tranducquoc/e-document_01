class AddPictureToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :picture, :string
  end
end
