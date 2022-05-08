# Yinfan Zhu
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :news
  after_create :sync_ela
  # hook to sync
  def sync_ela
    self.news.update_ela_record
  end
end
