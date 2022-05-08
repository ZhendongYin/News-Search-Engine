class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.date :date
      t.string :event
      t.timestamps
    end
  end
end
