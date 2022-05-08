class AddSentimentToNews < ActiveRecord::Migration[7.0]
  def change
    add_column :news, :sentiment, :float
  end
end
