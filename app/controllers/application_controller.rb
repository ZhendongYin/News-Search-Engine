# Yifan Zhu, Zhendong Yin
class ApplicationController < ActionController::Base
  include SessionsHelper
  
  # load source options
  def load_media
    @media = News.group(:source).count
    @media = @media.sort_by {|_key, value| value}.to_h.keys.reverse
    @latest_news = News.order(id: :desc).limit(10).includes(:comments)
  end

  # user login
  def authenticated!
    if !logged_in?
      redirect_to login_sessions_path
    end
  end
end
