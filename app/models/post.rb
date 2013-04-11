class Post < ActiveRecord::Base
  acts_as_url :title, :url_attribute => :slug, :only_when_blank => true
  validates_presence_of :title, :content, :published_at, :slug
  
  def self.available_statuses
    %w(draft live foo bar)
  end
  
    
end
