class Post < ActiveRecord::Base
  include Sluggable
  include Taggable
  
  validates_presence_of :title, :content, :published_at
  before_validation :ensure_published_date_set
  
  def self.available_statuses
    %w(draft live)
  end
  
  private
  
  def ensure_published_date_set
    if self.published_at.nil?
      self.published_at = DateTime.now 
    end
  end
    
end
