# database settinng
# Zhendong Yin
require 'active_record'
require 'sqlite3'
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: "news_datas"

ActiveRecord::Schema.define do
  create_table :news, :force => true do |t|
    t.string :title
    t.string :author
    t.string :source
    t.datetime :time
    t.text :content
    t.string :language, index: true
    t.timestamps
  end
end
