class Post < ActiveRecord::Base
  validates_presence_of :title, :content, :published_at
  
  def self.available_statuses
    %w(draft live foo bar)
  end
  
    
end
