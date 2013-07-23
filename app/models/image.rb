class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  validates_presence_of :image
  
  before_save :ensure_title_set

  private
  
  def ensure_title_set
    return unless self.title.blank?
    
    if self.image_identifier.blank?
      self.title = "untitled"
    else 
      self.title = self.image_identifier
    end
  end
  
end

