module Sluggable
  extend ActiveSupport::Concern
  include ActionView::Helpers::TextHelper
  
  included do
    validates_presence_of :slug
    validates_uniqueness_of :slug
    before_validation :ensure_slug_set
  end
  
  private
  

  def ensure_slug_set
    if self.slug.blank?
      self.slug = slugify(self.title) #todo - make this generic
    end
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