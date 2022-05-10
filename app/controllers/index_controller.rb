# Yifan Zhu, Zhendong Yin
require 'json'
require 'will_paginate/array'
require 'text'
class IndexController < ApplicationController
  before_action :load_media

  #index page
  def index
    @index = :index
    # comments number top3 
    @top_3 = News.find_by_sql("SELECT news.* FROM news LEFT JOIN comments c ON news.id = c.news_id GROUP BY news.id ORDER BY COUNT(c.id) DESC LIMIT 3")
    # latest news
    @latest_news = News.order(id: :desc).limit(10).includes(:comments)
  end

  # timeline page 
  def timeline
    @categories = Category.all.group_by(&:date)
    @page = :timeline
  end

  def results
    if params[:query].blank?
      redirect_to index_index_path
      return
    end
    filter = Stopwords::Snowball::Filter.new "en"
    @page = :results
    @cost = Time.now
    @q = params[:query]
    @from = params[:from]
    @to = params[:to]
    @source = params[:source]
    key_words = "#{@q}-#{@from}-#{@to}-#{@source}"
    @keyword = params[:query]
    # query processing
    stem = []
    filter.filter(@keyword.split).each do |e|
      stem << Text::PorterStemming.stem(e.downcase)
    end
    if false
    # redis cache resules
    # if @result = $redis_client.get(key_words)
      @result = eval(@result)
    else
      # build elasticsearch query
      body = {
        query: {
          function_score: {
            query: {
              bool: {
                should: [
                  {
                    match: {
                      stemmer: stem.join(" "),
                    }
                  },
                ]
              }
            },
            field_value_factor: {
              field: :comments,
              modifier: "log1p",
              factor: 0.1
            },
            boost_mode: :sum,
          },
        },
        size: 1000
      }

      if params[:from].present? or params[:to].present?
        body[:query][:function_score][:query][:bool][:must] << {
          range: {
            time: {
              gte: params[:from] == "" ? Date.parse('2022-01-01') : Date.parse(params[:from]),
              lte: params[:to] == "" ? Date.today : Date.parse(params[:to])
            }
          }
        }
      end

      if params[:source].present?
        body[:query][:function_score][:query][:bool][:must] << {
          match: {
            source: params[:source]
          }
        }
      end
      response = $client.search(index: $ela_index, body: body)
      @result = response['hits']['hits']

      $redis_client.set(key_words, @result, ex: 86400)
    end
    @result = @result.paginate(:page => params[:page], :per_page => 10)
    @cost = Time.now - @cost 
  end

  # news conntent page
  def show
    @page = :content
    @news = News.find_by(id: params[:id])
  end
end

