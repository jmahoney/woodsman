class Post < ActiveRecord::Base
  include Sluggable
  include Taggable
  
  DRAFT = 'draft'
  PUBLISHED = 'published'
  
  validates_presence_of :title, :content, :published_at
  before_validation :ensure_published_date_set
  before_save :ensure_date_slug_set
    
  def self.available_statuses
    [DRAFT, PUBLISHED]
  end
  
  def self.published
    where("status = '#{PUBLISHED}'")
  end
  
  # the archive pages show posts in order of published date
  def self.archive_order
    order("published_at ASC")
  end
  
  # the blog page shows posts in reverse-chronological order of published date
  def self.blog_order
    order("published_at DESC")
  end
  
  # get published posts for a specific year/month
  def self.month(year, month)
    posts = published.where("EXTRACT(YEAR FROM published_at) = ? AND EXTRACT(MONTH FROM published_at) = ?", year, month)
    if posts.empty?
      raise ActiveRecord::RecordNotFound
    else
      posts
    end
  end
  
  # post urls will always be in the format /2013/04/my-post-slug
  def to_param
    date_slug
  end
  
  private
  
  def ensure_published_date_set
    if self.published_at.nil?
      self.published_at = DateTime.now 
    end
  end
  
  def ensure_date_slug_set
    dt = self.published_at ? self.published_at : DateTime.now
    self.date_slug = "#{dt.strftime('%Y/%m')}/#{self.slug}"
  end
    
end
