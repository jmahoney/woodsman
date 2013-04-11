require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "post has draft status by default" do
    assert_equal('draft', Post.new.status)
  end
  
end
