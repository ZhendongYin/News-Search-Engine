# Zhendong Yin
class News < ApplicationRecord

  has_one :news_translation
  has_many :comments

  # hook of sync ela data
  def update_ela_record
    $client.update(index: $ela_index, id: self.ela_id, body: {doc: {comments: self.comments.size }})
  end

  # word stemmer
  def stemmer
    stem = []
    "#{self.news_translation&.title || self.title} #{self.news_translation&.content || self.content}".split(" ").each do |t|
      stem << Text::PorterStemming.stem(t.downcase)
    end
    $client.update(index: $ela_index, id: self.ela_id, body: {doc: {stemmer: stem.join(" ") }})
  end

  def export_sentiment
    $client.update(index: $ela_index, id: self.ela_id, body: {doc: {sentiment: self.sentiment}})
  end
end