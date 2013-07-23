require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "requires file to be set" do
    image = Image.new
    assert !image.save
    
    image.image = File.new(Rails.root.join('test','fixtures','300x300.png'))
    assert image.save
  end 
  
  test "accepts jpg, png, gif only" do
    image = Image.new
    
    image.image = File.new(Rails.root.join('test','fixtures','300x300.jpg'))
    assert image.save
    image.image = File.new(Rails.root.join('test','fixtures','300x300.png'))
    assert image.save
    image.image = File.new(Rails.root.join('test','fixtures','300x300.gif'))
    assert image.save
    image.image = File.new(Rails.root.join('test','fixtures','300x300.txt'))
    assert !image.save
  end
  
  test "creates a 100x100px thumbnail" do
    image = Image.new
    image.image = File.new(Rails.root.join('test','fixtures','300x300.jpg'))
    image.save    
    assert image.image.thumb.url
  end
  
  test "creates a 64x64 icon" do
    image = Image.new
    image.image = File.new(Rails.root.join('test','fixtures','300x300.jpg'))
    image.save
    
    assert image.image.icon.url
  end
  
  test "sets a title after saving if one does not exist" do
    image = Image.new
    image.image = File.new(Rails.root.join('test','fixtures','300x300.jpg'))
    image.save
    assert !image.title.blank?
  end
  
  test "sets a title after saving if the title is blank" do
    image = Image.new
    image.image = File.new(Rails.root.join('test','fixtures','300x300.jpg'))
    image.title = ""
    image.save
    assert !image.title.blank?
  end
  

end
