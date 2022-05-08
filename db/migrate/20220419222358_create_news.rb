class CreateNews < ActiveRecord::Migration[7.0]
  def change
    create_table :news do |t|
      t.string :title
      t.string :author
      t.string :source
      t.datetime :time
      t.text :content
      t.string :language, index: true
      t.timestamps
    end
  end
end
