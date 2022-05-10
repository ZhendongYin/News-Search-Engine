# save news data to database
#Zhendong Yin
require 'news-api'
require 'active_record'
require 'sqlite3'

KEY = ''
n = News.new(KEY)
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: "news_datas"

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class New < ApplicationRecord
  validates :title, uniqueness: true
end

# save news helpers
def save_news(news, language)
  content = {
    title: news.title,
    author: news.author,
    source: news.name,
    time: Date.parse(news.publishedAt),
    content: news.content,
    language: language
  }
  New.create!(content) rescue nil
end

# get news from api
def get_news(date, language, n)
  n.get_everything(q: 'Ukraine', from:"#{date.strftime}&to=#{date.strftime}", sortBy: 'publishedAt', language: language, pageSize: 100) rescue []
end

# script
loop do
  date = Date.today
  en_news = get_news(date, 'en', n)
  en_news.each do |news|
    save_news(news, 'en')
  end

  ru_news = get_news(date, 'ru', n)
  ru_news.each do |news|
    save_news(news, 'ru')
  end

  zh_news = get_news(date, 'zh', n)
  zh_news.each do |news|
    save_news(news, 'zh')
  end

  fr_news = get_news(date, 'fr', n)
  fr_news.each do |news|
    save_news(news, 'fr')
  end

  sleep 24.hours
end