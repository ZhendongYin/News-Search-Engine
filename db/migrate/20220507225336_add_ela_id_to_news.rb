class AddElaIdToNews < ActiveRecord::Migration[7.0]
  def change
    add_column :news, :ela_id, :string
  end
end
