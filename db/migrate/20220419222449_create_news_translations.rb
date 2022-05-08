class CreateNewsTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :news_translations do |t|
      t.references :news
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
