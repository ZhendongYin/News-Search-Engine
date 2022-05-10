# Zhendong Yin
# import data script
desc 'import to elasticsearch'
namespace :import do
  task elasticsearch: :environment do
    require "google/cloud/translate/v2"
    require 'elasticsearch'
    key = "AIzaSyCchmYhlK2XNdbvSf7trocydI8jv6a7Ay0"
    e_client = Elasticsearch::Client.new log: true
    client = Google::Cloud::Translate::V2.new(key: key)
    filter = Stopwords::Snowball::Filter.new "en"

    keys = $ela_index
    `curl -XDELETE http://localhost:9200/#{keys}`

    # translate news
    News.includes(:news_translation).find_each do |news|
      next if news.language == 'en' or news.news_translation.present?
      a = NewsTranslation.new
      _title = client.translate(news.title, to: "en")
      _content = client.translate(news.content, to: "en")
      a.news_id = news.id
      a.title = _title.text
      a.author = news.author
      a.source = news.source
      a.time = news.time
      a.content = _content.text
      a.language = news.language
      a.save
    end

    News.includes(:news_translation, :comments).find_each do |news|
      puts news.title
      # word processing 
      stem = []
      filter.filter("#{news.news_translation&.title || news.title} #{news.news_translation&.content || news.content}".split).each do |t|
        stem << Text::PorterStemming.stem(t.downcase)
      end

      data =  {
        id: news.id,
        title: news.title,
        author: news.author,
        source: news.source,
        time: news.time,
        content: news.content,
        language: news.language,
        title_translation: news.news_translation&.title || news.title,
        content_translation: news.news_translation&.content || news.content,
        stemmer: stem.join(" "),
        comments: news.comments.size,
        sentiment: news.sentiment
      }
      # save to elasticsearch
      response = e_client.index(index: $ela_index, body: data)
      news.ela_id = response['_id']
      news.save
    end
  end
  
  # import sentiment to database
  task sentiment: :environment do
    require 'csv'
    csv = File.read("#{Rails.root}/public/product_output.csv")
    id = News.first.id
    CSV.parse(csv, headers: true).each do |row|

      news = News.find(id).update(sentiment: row['label']) rescue next
      id += 1
    end
  end

  # import comments to database
  task comments: :environment do
    require 'csv'
    csv = CSV.read("#{Rails.root}/public/comments.csv")[1..-1]
    length = csv.size
    user_size = User.count

    News.find_each do |news|
      (rand(10) + 1).times do |t|
          c = news.comments.new
          c.user_id = rand(user_size) + 1
          c.content = csv[rand(length)][3]
          c.save
      end
    end
  end

  # import test_data to database
  task test_data: :environment do
    file = File.read("#{Rails.root}/public/test_data.json")
    json = eval file
    json.each do |value|
      news = News.new
      news.title = value['title']
      news.author = value['author']
      news.source = value['source']
      news.time = value['time']
      news.content = value['content']
      news.language = value['language']
      news.sentiment = value['sentiment']
      news.save
    end
  end

  # # import whole data to database
  task whole_data: :environment do
    require "sqlite3"
    db = SQLite3::Database.new "#{Rails.root}/news_datas"
    db.execute( "select * from news" ) do |row|
      news = News.new
      news.title = row[1]
      news.author = row[2]
      news.source = row[3]
      news.time = row[4]
      news.content = row[5]
      news.language = row[6]
      news.save
    end

    # sync sentiment
    require 'csv'
    csv = File.read("#{Rails.root}/public/product_output.csv")
    id = News.first.id
    CSV.parse(csv, headers: true).each do |row|

      news = News.find(id).update(sentiment: row['label']) rescue next
      id += 1
    end
  end
end