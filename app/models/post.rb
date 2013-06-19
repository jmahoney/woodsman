class Post < ActiveRecord::Base
  include Taggable
  
  DRAFT = 'draft'
  PUBLISHED = 'published'
  
  validates_presence_of :title, :content, :published_at, :slug
  validates_uniqueness_of :slug
  before_validation :ensure_published_date_set, :ensure_slug_set
  before_save :ensure_date_slug_set
  before_validation :ensure_slug_set
  
  def self.available_statuses
    [DRAFT, PUBLISHED]
  end
  
  def self.published
    where("status = ?", PUBLISHED)
  end
  
  def self.draft
    where("status = ?", DRAFT)
  end
  
  # get the data structure representing the tag archive of published posts
  def self.tag_archive
    self.published.select("UNNEST(tags) as tag, COUNT(id) AS post_count").group("UNNEST(tags)").order("count(id) DESC")
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
    dt = Time.zone.local(year, month, 1, 0, 0)
    posts = published.where(published_at: dt.beginning_of_month..dt.end_of_month)
    if posts.empty?
      raise ActiveRecord::RecordNotFound
    else
      posts
    end
  end
  
  # return the next post in chronological order
  def next
    self.class.where('published_at > ? AND status = ?', self.published_at, self.status).limit(1).first
  end
  
  # return the previous post in chronological order
  def previous
    self.class.where("published_at < ? AND status = ?", self.published_at, self.status).limit(1).first
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
  
  def ensure_slug_set
    if self.slug.blank?
      self.slug = slugify(self.title) #todo - make this generic
    end
  end
  
  def ensure_date_slug_set
    dt = self.published_at ? self.published_at : DateTime.now
    self.date_slug = "#{dt.strftime('%Y/%m')}/#{self.slug}"
  end

  #turn a supplied string into a readable string containing only
  #alphanumeric characters & dashes. Make an attempt to 
  def slugify(str)
    str ||= ""
    new_slug = str.dasherize.parameterize
    if self.class.find_by_slug(new_slug)
      new_slug = new_slug + DateTime.now.strftime("-%H%M%S")
    end
    new_slug
  end
end
